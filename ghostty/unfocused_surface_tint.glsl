const float DIM_AMOUNT = 0.08;
const float DESATURATE_AMOUNT = 0.14;
const float TINT_AMOUNT = 0.05;
const float VIGNETTE_AMOUNT = 0.05;
const float TEXT_PRESERVE_AMOUNT = 0.62;
const vec3 WARM_TINT = vec3(1.0, 0.78, 0.48);

float luminance(vec3 color)
{
    return dot(color, vec3(0.299, 0.587, 0.114));
}

vec3 desaturate(vec3 color, float amount)
{
    float gray = luminance(color);
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
    float brightness = luminance(fragColor.rgb);
    float textPreserve = smoothstep(0.35, 0.78, brightness) * TEXT_PRESERVE_AMOUNT;
    float effectStrength = 1.0 - textPreserve;
    float dim = (DIM_AMOUNT + vignette * VIGNETTE_AMOUNT) * effectStrength;

    vec3 color = desaturate(fragColor.rgb, DESATURATE_AMOUNT * effectStrength);
    color = mix(color, color * WARM_TINT, TINT_AMOUNT * effectStrength);
    fragColor.rgb = color * (1.0 - dim);
}
