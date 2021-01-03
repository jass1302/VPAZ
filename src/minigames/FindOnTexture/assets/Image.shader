shader_type canvas_item;
uniform vec2 mouse_pos = vec2(0.0, 0.0);
uniform float aspect_ratios = 1.0;
vec2 zoom_point(vec2 uv, vec2 point, float zoom)
{
    return (uv - point) / zoom + point;
}
void fragment()
{
    vec2 uv = SCREEN_UV;
    float lens_radius = 0.08;
    float mouse_dist = distance(uv*vec2(1.0, aspect_ratios), mouse_pos*vec2(1.0, aspect_ratios));
    if (mouse_dist < lens_radius)
    {
        float zoom = 2.0;
        vec2 zoomed = zoom_point(uv, mouse_pos, zoom);
        COLOR = vec4(texture(SCREEN_TEXTURE, zoomed).rgb, 1.0);
    }
    else if (mouse_dist < lens_radius + 0.004)
    {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    }
    else
    {
        discard;
        //COLOR = vec4(0.0, 0.0, 0.0, 0.35);
        //COLOR = vec4(textureLod(SCREEN_TEXTURE, uv, 2).rgb, 1.0);
    }
}