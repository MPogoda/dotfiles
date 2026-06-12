const float RIM_WIDTH = 2.2;
const float RIM_SOFTNESS = 2.0;
const float RIM_OPACITY = 0.22;
const float CORNER_FADE_RADIUS = 46.0;

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

    vec3 rimColor = mix(iCurrentCursorColor.rgb, vec3(1.0), 0.18);
    fragColor.rgb = mix(fragColor.rgb, rimColor, rim * RIM_OPACITY);
}
