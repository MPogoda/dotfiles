const float DIM_AMOUNT = 0.08;
const float DESATURATE_AMOUNT = 0.14;
const float TINT_AMOUNT = 0.05;
const float VIGNETTE_AMOUNT = 0.05;
const vec3 WARM_TINT = vec3(1.0, 0.78, 0.48);

vec3 desaturate(vec3 color, float amount)
{
    float gray = dot(color, vec3(0.299, 0.587, 0.114));
    return mix(color, vec3(gray), amount);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord / iResolution.xy;
    fragColor = texture(iChannel0, uv);

    if (iFocus == 1) {
        return;
    }

    vec2 centered = uv * 2.0 - 1.0;
    float vignette = smoothstep(0.3, 1.35, length(centered));
    float dim = DIM_AMOUNT + vignette * VIGNETTE_AMOUNT;

    vec3 color = desaturate(fragColor.rgb, DESATURATE_AMOUNT);
    color = mix(color, color * WARM_TINT, TINT_AMOUNT);
    fragColor.rgb = color * (1.0 - dim);
}
