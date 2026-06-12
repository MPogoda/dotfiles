const float RIM_WIDTH = 2.2;
const float RIM_SOFTNESS = 2.0;
const float RIM_OPACITY = 0.22;
const float CORNER_FADE_RADIUS = 46.0;
const vec3 LUMINANCE_WEIGHTS = vec3(0.299, 0.587, 0.114);
const vec3 FALLBACK_CURSOR_COLOR = vec3(0.8, 0.725, 0.161);

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
    vec2 uv = fragCoord / iResolution.xy;
    fragColor = texture(iChannel0, uv);

    if (iFocus == 0) {
        return;
    }

    vec2 edgeDistance = min(fragCoord, iResolution.xy - fragCoord);
    float nearestEdge = min(edgeDistance.x, edgeDistance.y);
    float rim = 1.0 - smoothstep(RIM_WIDTH, RIM_WIDTH + RIM_SOFTNESS, nearestEdge);

    vec2 nearestCorner = min(fragCoord, iResolution.xy - fragCoord);
    float cornerDistance = length(nearestCorner);
    float cornerFade = smoothstep(0.0, CORNER_FADE_RADIUS, cornerDistance);
    rim *= mix(0.35, 1.0, cornerFade);

    vec3 rimColor = mix(cursorColor(), vec3(1.0), 0.18);
    fragColor.rgb = mix(fragColor.rgb, rimColor, rim * RIM_OPACITY);
}
