# NeoMate

A flexible, battery-backed phototherapy swaddle for newborns with jaundice.

Team ID: VK26-IITI-HT-0323
Track: Health Tech
Submitted to: Vishwakarma Awards 2026-27 (Stage 2)

## Why we're building this

Newborn jaundice is usually treated with blue light, but most units are rigid and sit above the baby. That means the baby stays away from the mother, needs separate eye patches that can slip, and the treatment stops whenever the power goes out. In hospitals with unreliable electricity, that gap matters.

NeoMate tries to fix this with a soft swaddle that the mother can hold the baby in while the light does its work.

## The idea

- A flexible LED matrix (around 460 nm) sewn into a washable silicone and fabric swaddle
- A small battery pack that keeps therapy running for about 4 hours during a power cut
- An ESP32 that logs data offline and syncs when a connection is available
- Two thermistors wired to a hardware relay, so the lights cut off if the skin side gets too warm, even if the firmware crashes
- A feeding timer that pauses therapy and reminds the caregiver
- A bilirubin (TCB) sensor that only tracks trends. It is not a diagnostic tool and is meant to remind people to get a proper blood test.

## Where we are right now

This is still a concept and design project. We have worked out the architecture, parts list, safety logic and plan on paper. Nothing has been built or tested on a real baby, and we haven't built a working prototype yet. Fabrication is planned to start in Month 1.

We'll add files here as we make them, so the commit history shows the real progress.

## Repository layout

- `/cad` : OpenSCAD files for the swaddle (coming soon)
- `/electronics` : KiCad schematic and PCB (coming soon)
- `/docs` : BOM, battery calculation, FMEA
- `/concept-images` : illustrations used in our slides

## About the images

The pictures in `/concept-images` were generated with AI to explain the idea. They are not photos of a real prototype and they are not test results.

## Rough prototype cost

About Rs 3,250 for the first bench prototype (ESP32, flexible LED matrix, Li-Po battery, thermistors and relay, TCB sensor). The battery size still needs to be checked against our power calculation.

## Plan

- Month 1: build the LED matrix and PCB, order parts
- Month 2: add the thermal relay and battery backup, bench test
- Month 3: firmware (logging, feeding timer, TCB trends), check light output with a radiometer
- Month 4: a safety-tested prototype for the Stage 3 live demo

## Standards we are designing towards

IEC 60601-2-50 (infant phototherapy equipment), IEC 60601-1, IEC 60601-1-2, ISO 10993 and IEC 62133. We are not claiming compliance yet. These are the guidelines we are using as targets.

## Team
Kratos
(Nagaland University)
