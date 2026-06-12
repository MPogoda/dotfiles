float sdBox(in vec2 point, in vec2 center, in vec2 halfSize)
{
    vec2 delta = abs(point - center) - halfSize;
    return length(max(delta, 0.0)) + min(max(delta.x, delta.y), 0.0);
}

vec2 normalizeCoord(vec2 value, float isPosition)
{
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

float parametricBlend(float t)
{
    float squared = t * t;
    return squared / (2.0 * (squared - t) + 1.0);
}

const vec4 CURSOR_COLOR = vec4(0.8, 0.725, 0.161, 1.0);
const vec4 CURSOR_ACCENT = vec4(1.0, 0.0, 0.0, 1.0);
const float DURATION = 0.1;

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
#if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
#endif

    vec2 position = normalizeCoord(fragCoord, 1.0);
    vec4 cursor = vec4(
        normalizeCoord(iCurrentCursor.xy, 1.0),
        normalizeCoord(iCurrentCursor.zw, 0.0)
    );

    float progress = parametricBlend(clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0));
    vec2 cursorCenter = cursor.xy - cursor.zw * vec2(-0.5, 0.5);
    float cursorDistance = sdBox(position, cursorCenter, cursor.zw * 0.5);
    float cursorMask = 1.0 - smoothstep(cursorDistance, 0.0, 0.003 * (1.0 - progress));

    vec4 cursorLayer = mix(fragColor, CURSOR_ACCENT, cursorMask);
    fragColor = mix(cursorLayer, CURSOR_COLOR, cursorMask);
}
