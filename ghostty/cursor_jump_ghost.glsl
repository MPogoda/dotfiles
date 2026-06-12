const float JUMP_DURATION = 0.24;
const float CELL_MANHATTAN_THRESHOLD = 30.0;
const float FOCUS_SUPPRESSION = 0.54;
const float START_SCALE = 4.0;
const float END_SCALE = 1.4;
const float MAX_OPACITY = 0.30;
const float CORNER_RADIUS_RATIO = 0.28;
const float TRAIL_LENGTH = 0.42;

float easeOutCubic(float value)
{
    float inverse = 1.0 - value;
    return 1.0 - inverse * inverse * inverse;
}

float sdRoundedBox(vec2 point, vec2 halfSize, float radius)
{
    vec2 delta = abs(point) - halfSize + vec2(radius);
    return length(max(delta, 0.0)) + min(max(delta.x, delta.y), 0.0) - radius;
}

float shellMask(vec2 point, vec2 halfSize, float radius, float progress, float opacity)
{
    float distance = sdRoundedBox(point, halfSize, radius);
    float ring = 1.0 - smoothstep(0.0, 3.0, abs(distance));
    float glow = 1.0 - smoothstep(0.0, 12.0, abs(distance));

    return (ring + glow * 0.18) * opacity * (1.0 - progress);
}

float sdSegment(vec2 point, vec2 start, vec2 end, float radius)
{
    vec2 segment = end - start;
    float segmentLength = max(dot(segment, segment), 1.0);
    float t = clamp(dot(point - start, segment) / segmentLength, 0.0, 1.0);
    vec2 closest = start + segment * t;

    return length(point - closest) - radius;
}

float ghostTrailMask(vec2 point, vec2 start, vec2 end, float radius, float opacity)
{
    float distance = sdSegment(point, start, end, radius);
    float core = 1.0 - smoothstep(-1.0, 2.0, distance);
    float glow = 1.0 - smoothstep(0.0, 9.0, abs(distance));

    return (core + glow * 0.22) * opacity;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord / iResolution.xy;
    fragColor = texture(iChannel0, uv);

    float elapsed = iTime - iTimeCursorChange;
    float focusElapsed = iTime - iTimeFocus;
    vec2 cursorDelta = abs(iCurrentCursor.xy - iPreviousCursor.xy);
    vec2 cursorCellSize = max(iCurrentCursor.zw, vec2(1.0));
    float cellManhattanDistance = cursorDelta.x / cursorCellSize.x + cursorDelta.y / cursorCellSize.y;

    if (
        iFocus == 0 ||
        elapsed < 0.0 ||
        elapsed > JUMP_DURATION ||
        cellManhattanDistance <= CELL_MANHATTAN_THRESHOLD ||
        (focusElapsed >= 0.0 && focusElapsed < FOCUS_SUPPRESSION)
    ) {
        return;
    }

    float rawProgress = elapsed / JUMP_DURATION;
    vec2 cursorSize = iCurrentCursor.zw;
    float baseSize = max(cursorSize.x, cursorSize.y);
    vec2 currentCenter = iCurrentCursor.xy + vec2(cursorSize.x * 0.5, -cursorSize.y * 0.5);
    vec2 previousCenter = iPreviousCursor.xy + vec2(cursorSize.x * 0.5, -cursorSize.y * 0.5);
    float mask = 0.0;

    for (int index = 0; index < 5; index++) {
        float segmentSize = TRAIL_LENGTH / 5.0;
        float segmentEnd = rawProgress - segmentSize * float(index);
        float segmentStart = segmentEnd - segmentSize * 0.82;

        if (segmentEnd <= 0.0 || segmentStart >= 1.0) {
            continue;
        }

        float startValue = clamp(segmentStart, 0.0, 1.0);
        float endValue = clamp(segmentEnd, 0.0, 1.0);
        vec2 ghostStart = mix(previousCenter, currentCenter, startValue);
        vec2 ghostEnd = mix(previousCenter, currentCenter, endValue);
        float tailProgress = float(index) / 4.0;
        float trailRadius = baseSize * 0.16;
        float ghostOpacity = MAX_OPACITY * 0.28 * (1.0 - tailProgress * 0.7);

        mask += ghostTrailMask(fragCoord, ghostStart, ghostEnd, trailRadius, ghostOpacity);
    }

    float pulseProgress = clamp((rawProgress - 0.62) / 0.38, 0.0, 1.0);
    float progress = easeOutCubic(pulseProgress);
    float scale = mix(START_SCALE, END_SCALE, progress);
    vec2 halfSize = vec2(baseSize * scale * 0.5);
    float radius = halfSize.x * CORNER_RADIUS_RATIO;
    mask += shellMask(fragCoord - currentCenter, halfSize, radius, progress, MAX_OPACITY * step(0.62, rawProgress));

    mask = clamp(mask, 0.0, 1.0);
    fragColor.rgb = mix(fragColor.rgb, iCurrentCursorColor.rgb, mask);
}
