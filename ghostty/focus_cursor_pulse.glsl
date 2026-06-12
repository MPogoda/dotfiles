const float PULSE_DURATION = 0.54;
const float START_SCALE = 8.0;
const float END_SCALE = 3.125;
const float MAX_OPACITY = 0.26;
const float CORNER_RADIUS_RATIO = 0.28;
const vec3 LUMINANCE_WEIGHTS = vec3(0.299, 0.587, 0.114);
const vec3 FALLBACK_CURSOR_COLOR = vec3(0.8, 0.725, 0.161);
const vec3 WARM_ACCENT = vec3(1.0, 0.55, 0.18);

float luminance(vec3 color)
{
    return dot(color, LUMINANCE_WEIGHTS);
}

vec3 cursorColor()
{
    float cursorBrightness = luminance(iCurrentCursorColor.rgb);
    return mix(FALLBACK_CURSOR_COLOR, iCurrentCursorColor.rgb, step(0.01, cursorBrightness));
}

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

float pulseShell(vec2 point, vec2 halfSize, float radius, float progress, float opacity)
{
    float distance = sdRoundedBox(point, halfSize, radius);
    float outlineWidth = 3.0;
    float softness = 3.0;
    float outer = 1.0 - smoothstep(0.0, softness, distance);
    float inner = 1.0 - smoothstep(0.0, softness, distance + outlineWidth);
    float ring = clamp(outer - inner, 0.0, 1.0);
    float glow = 1.0 - smoothstep(0.0, 18.0, abs(distance));

    return (ring + glow * 0.22) * opacity * (1.0 - progress);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord / iResolution.xy;
    fragColor = texture(iChannel0, uv);

    float elapsed = iTime - iTimeFocus;
    if (iFocus == 0 || elapsed < 0.0 || elapsed > PULSE_DURATION) {
        return;
    }

    vec2 cursorSize = iCurrentCursor.zw;
    vec2 cursorCenter = iCurrentCursor.xy + vec2(cursorSize.x * 0.5, -cursorSize.y * 0.5);
    vec2 point = fragCoord - cursorCenter;
    float baseSize = max(cursorSize.x, cursorSize.y);
    float rawProgress = elapsed / PULSE_DURATION;
    float mask = 0.0;

    for (int index = 0; index < 4; index++) {
        float trail = float(index) * 0.075;
        float sampleProgress = rawProgress - trail;

        if (sampleProgress >= 0.0) {
            float progress = easeOutCubic(clamp(sampleProgress, 0.0, 1.0));
            float scale = mix(START_SCALE, END_SCALE, progress);
            vec2 halfSize = vec2(baseSize * scale * 0.5);
            float radius = halfSize.x * CORNER_RADIUS_RATIO;
            float opacity = MAX_OPACITY * pow(0.58, float(index));

            mask += pulseShell(point, halfSize, radius, progress, opacity);
        }
    }

    mask = clamp(mask, 0.0, 1.0);
    vec3 pulseColor = mix(cursorColor(), WARM_ACCENT, 0.18);
    fragColor.rgb = mix(fragColor.rgb, pulseColor, mask);
}
