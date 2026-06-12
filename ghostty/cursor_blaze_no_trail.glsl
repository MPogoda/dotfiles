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

const vec3 LUMINANCE_WEIGHTS = vec3(0.299, 0.587, 0.114);
const vec3 FALLBACK_CURSOR_COLOR = vec3(0.8, 0.725, 0.161);
const vec3 WARM_ACCENT = vec3(1.0, 0.55, 0.18);
const float DURATION = 0.1;

float luminance(vec3 color)
{
    return dot(color, LUMINANCE_WEIGHTS);
}

vec3 cursorColor()
{
    float cursorBrightness = luminance(iCurrentCursorColor.rgb);
    return mix(FALLBACK_CURSOR_COLOR, iCurrentCursorColor.rgb, step(0.01, cursorBrightness));
}

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

    vec3 color = cursorColor();
    vec3 accent = mix(color, WARM_ACCENT, 0.28);
    vec4 cursorLayer = mix(fragColor, vec4(accent, 1.0), cursorMask);
    fragColor = mix(cursorLayer, vec4(color, 1.0), cursorMask);
}
