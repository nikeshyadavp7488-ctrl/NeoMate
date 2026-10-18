# NeoMate: KiCad schematic plan (draw this, then commit the .kicad_sch)

Status: a wiring plan for the schematic, not a finished circuit. Values are starting points and must be checked against datasheets before building.

## Sheets to draw
1. Power
2. Controller (ESP32)
3. LED drive
4. Safety cut-off (independent of firmware)
5. Sensors and user interface

## 1. Power
| Block | Plan |
|---|---|
| Battery | 2S protected pack (7.4 V nominal, 8.4 V full) with BMS |
| Charging | USB-C input into a 2S charger board. Note: a plain 5 V USB-C input cannot charge a 2S pack. Use a boost-charger module or a USB-C PD trigger set to 9-12 V |
| Regulation | Buck converter 7.4 V to 5 V, at least 1 A, feeds the LED strip and the ESP32 board VIN |
| Battery monitor | Divider 100k / 33k from the pack to GPIO32 (2.1 V at 8.4 V, safe for the ADC) |

## 2. Controller: ESP32 pin plan
| Function | GPIO | Note |
|---|---|---|
| Thermistor 1 (primary) | 34 | ADC1, input only |
| Thermistor 2 (redundant) | 35 | ADC1, input only |
| Battery voltage | 32 | ADC1 |
| LED PWM to MOSFET gate | 25 | add 100 ohm series and 100k pulldown |
| Relay status read-back | 33 | reads the comparator output |
| I2C SDA / SCL (TCB sensor) | 21 / 22 | 3.3 V sensor |
| Buzzer | 27 | feeding-timer alert |
| Snooze / reset button | 26 | to GND, internal pull-up |

Use ADC1 pins only. ADC2 pins stop working when Wi-Fi is on.

## 3. LED drive
- Low-side logic-level MOSFET switches the LED strip ground; GPIO25 drives the gate.
- Nine strips of 12 LEDs in parallel, matching the 12 x 9 CAD matrix.
- The relay contact sits in the +5 V line to the strips (see section 4).

## 4. Safety cut-off (no firmware involved)
- Each thermistor: 10k NTC (B3950) in a divider with a 10k fixed resistor from 3.3 V.
- Two LM393 comparators, one per thermistor, each compared with a trimmer-set reference for the cut-off temperature.
- Either comparator output drives a transistor that switches the relay coil.
- Design note: as drawn in the slides (normally-closed contact, coil energised to cut), a broken coil circuit leaves the LEDs on. A safer choice is a normally-open relay held energised in normal use, so any loss of power or wiring fault turns the LEDs off. Decide this before drawing.
- Add a flyback diode across the relay coil.

## 5. Sensors and interface
- TCB sensor candidate on I2C (3.3 V), with 4.7k pull-ups on SDA and SCL.
- Buzzer through a small transistor, snooze button with debounce capacitor.

## Drawing steps in KiCad
1. File, New Project. Name it neomate.
2. Add symbols: ESP32 module, LM393, MOSFET, NPN transistor, relay, diode, connectors, passives.
3. Wire each sheet as above and add net labels (+7V4, +5V, +3V3, GND).
4. Annotate (Tools, Annotate Schematic), then run the ERC and fix every error.
5. Screenshot the finished schematic. Commit the .kicad_sch, .kicad_pro and a PDF export to the electronics folder on GitHub.
6. If you lay out the PCB, run the DRC and screenshot the report.
