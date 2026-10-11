# NeoMate: 4-hour battery estimate (design calculation)

Status: first-pass estimate on paper. The efficiency numbers below are assumptions and must be replaced with measured values after bench testing with a radiometer.

## Inputs (assumptions)
| Item | Value |
|---|---|
| Active LED area | 300 cm2 (200 x 150 mm) |
| Target irradiance | 30 uW/cm2/nm (intensive-care level; verify against IEC 60601-2-50) |
| Effective bandwidth | 30 nm |
| Optical coupling (silicone + fabric losses) | 50% |
| LED wall-plug efficiency (blue SMD) | 30% |
| Driver efficiency | 85% |
| ESP32 + sensors average load | 0.45 W (relay coil is off in normal operation) |
| Backup time | 4 h |
| Usable battery depth | 80% |
| Design margin | 2x |

## Steps
1. Power needed at the skin = 30 x 30 x 300 = 270,000 uW = **270 mW**
2. Light the LEDs must emit = 270 / 0.5 = **540 mW**
3. LED electrical power = 540 mW / 0.3 = **1.80 W**
4. With driver loss = 1.80 / 0.85 = **2.12 W**
5. Total with electronics = 2.12 + 0.45 = **2.57 W**
6. Energy for 4 h = 2.57 x 4 = **10.3 Wh**
7. Minimum pack size = 10.3 / 0.8 = **12.8 Wh**
8. Design target with 2x margin = **~26 Wh**

## Result
A 2S Li-Po (7.4 V nominal) of about **3.5 Ah or more** (~26 Wh).

LED drive: with 108 LEDs (12 x 9, as in the OpenSCAD model), 17 mW each, about 6 mA per LED at 3.0 V. Running many LEDs at low current keeps heat and brightness more even.

## To check later
- Measure real irradiance with a radiometer and update the two efficiencies.
- Check that the pack's real price and size fit the BOM (the earlier Rs 850 line is not confirmed).
- Add a charge-protection and discharge cut-off circuit (UPMS) to the schematic.
