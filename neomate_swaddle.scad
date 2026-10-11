// NeoMate swaddle panel - parametric CONCEPT model (Stage 2)
// Layers (skin side on top): silicone / LED flex PCB / graphene backing / fabric
// Assembled:  openscad -o neomate.stl neomate_swaddle.scad
// Exploded:   openscad -D explode=12 -o neomate_exploded.png neomate_swaddle.scad

explode  = 0;      // mm gap between layers (0 = assembled)
panel_w  = 200;    // mm, LED panel width
panel_h  = 150;    // mm, LED panel height (about 300 cm2 active area)
corner_r = 15;

t_fab = 1.2;  t_back = 1.0;  t_pcb = 0.3;  led_h = 0.8;  t_sil = 1.5;
led_cols = 12;  led_rows = 9;  led_size = 3;  margin = 15;   // 108 LEDs

module rrect(w, h, r, t) {
    linear_extrude(t) hull()
        for (x = [r, w - r], y = [r, h - r]) translate([x, y]) circle(r = r, $fn = 40);
}

z_back = t_fab + explode;
z_pcb  = t_fab + t_back + 2 * explode;
z_sil  = z_pcb + t_pcb + 3 * explode;
px = (panel_w - 2 * margin - led_size) / (led_cols - 1);
py = (panel_h - 2 * margin - led_size) / (led_rows - 1);

// Layer 4: outer fabric wrap
translate([-10, -10, 0]) color("Beige") rrect(panel_w + 20, panel_h + 20, corner_r, t_fab);
// Layer 3: graphene-infused thermal backing (proposed)
translate([0, 0, z_back]) color("DimGray") rrect(panel_w, panel_h, corner_r, t_back);
// Layer 2: flexible PCB + 460 nm SMD LEDs
translate([0, 0, z_pcb]) {
    color("DarkGreen") rrect(panel_w, panel_h, corner_r, t_pcb);
    for (i = [0 : led_cols - 1], j = [0 : led_rows - 1])
        translate([margin + i * px, margin + j * py, t_pcb])
            color("DeepSkyBlue") cube([led_size, led_size, led_h]);
    // two NTC thermistors (primary + redundant) next to the LED field
    for (p = [[margin - 6, margin - 6], [panel_w - margin + 6, panel_h - margin + 6]])
        translate([p[0], p[1], t_pcb]) color("Orange") cylinder(d = 3, h = 1.5, $fn = 24);
}
// Layer 1: medical silicone, skin side (translucent)
translate([0, 0, z_sil]) color([0.8, 0.9, 1, 0.35]) rrect(panel_w, panel_h, corner_r, t_sil);
// External control pod (ESP32 + battery + relay), connected by cable
translate([panel_w + 25, 0, 0]) color("Silver") cube([80, 50, 20]);
