# Stiffened-Panel Buckling Optimisation (Aluminium 6061-T6)

Parametric linear-buckling and response-surface optimisation of welded Aluminium 6061-T6 stiffened panels under uniform axial compression. ANSYS Mechanical 2024 R1 produces the buckling loads for a 3 × 3 × 3 full-factorial DOE; MATLAB R2026a fits response surfaces, runs ANOVA, and locates the Pareto-optimal subset.

---

## Headline results

| Metric | Value |
|---|---|
| Configurations studied | 27 panels (3³ full factorial) |
| Strength-to-weight optimum | **Panel 13** &nbsp;·&nbsp; *t* = 3 mm, *h* = 35 mm, *b* = 100 mm &nbsp;·&nbsp; 94.58 kN/kg |
| Load-maximising optimum (RSM grid) | *t* = 4.00 mm, *h* = 44.33 mm, *b* = 100 mm &nbsp;·&nbsp; *P*ᶜʳ = 754.0 kN |
| Pareto-optimal panels | 15 of 27 |
| Surrogate R² &nbsp;(*P*ᶜʳ / Mass / Ratio) | 0.923 / 0.9999 / 0.890 |

---

## Geometry and design space

Flat skin plate 1000 mm × 600 mm with longitudinal blade stiffeners welded along the full length. Three design variables, three levels each:

| Variable | Symbol | Levels |
|---|---|---|
| Skin thickness | *t* (mm) | 2, 3, 4 |
| Stiffener height | *h* (mm) | 25, 35, 45 |
| Stiffener spacing | *b* (mm) | 100, 150, 200 |

Stiffener count is set by *b*: 5 stiffeners at *b* = 100, 3 at *b* = 150, 2 at *b* = 200.

<!-- Drop the CAD screenshot from ANSYS SpaceClaim here (1000 × 600 mm panel with 5 stiffeners) -->
![CAD geometry — b = 100 mm configuration](images/geometry/cad_b100.png)

---

## Finite-element model

ANSYS Mechanical 2024 R1, four-node SHELL181 elements, midsurface shell representation, 10 mm element size selected after a five-level convergence study. Linear elastic Aluminium 6061-T6 (E = 70 GPa, ν = 0.33, ρ = 2700 kg/m³). Uniform axial compression delivered by a 1 kN reference compressive pressure on the loaded edge; eigenvalue buckling gives the load multiplier *λ*₁ and hence *P*ᶜʳ.

<!-- Drop the meshed-model screenshot here -->
![Meshed FE model](images/mesh/mesh_10mm.png)

### Mesh convergence

Convergence performed on Panel 14 (central design point: *t* = 3 mm, *h* = 35 mm, *b* = 150 mm). Five element sizes tested: 20, 15, 10, 7, 5 mm.

<!-- Add mesh convergence screenshots; one per mesh density -->
| 20 mm | 15 mm | 10 mm (selected) | 7 mm | 5 mm |
|:---:|:---:|:---:|:---:|:---:|
| ![](images/mesh/mesh_20mm.png) | ![](images/mesh/mesh_15mm.png) | ![](images/mesh/mesh_10mm.png) | ![](images/mesh/mesh_7mm.png) | ![](images/mesh/mesh_5mm.png) |
| *λ*₁ = 261.73 | 258.22 | 255.52 | 254.32 | 253.63 |

The first eigenvalue stabilised below 1 % change per refinement step from 10 mm downward — 10 mm was selected for production runs.

---

## 27-panel results gallery

Linear buckling mode shape for each of the 27 configurations. Panel 13 and Panel 22 are highlighted as the two design candidates.

<!-- Drop all 27 panel mode-shape screenshots into images/modes/ named panel_01.png ... panel_27.png -->

<details>
<summary><b>Show all 27 panels (click to expand)</b></summary>

| Panel | *t* (mm) | *h* (mm) | *b* (mm) | *P*ᶜʳ (kN) | Mode shape |
|:---:|:---:|:---:|:---:|---:|:---:|
| 1 | 2 | 25 | 100 | 218.9 | ![](images/modes/panel_01.png) |
| 2 | 2 | 25 | 150 | 86.2 | ![](images/modes/panel_02.png) |
| 3 | 2 | 25 | 200 | 44.8 | ![](images/modes/panel_03.png) |
| 4 | 2 | 35 | 100 | 227.0 | ![](images/modes/panel_04.png) |
| 5 | 2 | 35 | 150 | 88.2 | ![](images/modes/panel_05.png) |
| 6 | 2 | 35 | 200 | 45.6 | ![](images/modes/panel_06.png) |
| 7 | 2 | 45 | 100 | 235.4 | ![](images/modes/panel_07.png) |
| 8 | 2 | 45 | 150 | 90.2 | ![](images/modes/panel_08.png) |
| 9 | 2 | 45 | 200 | 46.3 | ![](images/modes/panel_09.png) |
| 10 | 3 | 25 | 100 | 341.4 | ![](images/modes/panel_10.png) |
| 11 | 3 | 25 | 150 | 243.0 | ![](images/modes/panel_11.png) |
| 12 | 3 | 25 | 200 | 131.2 | ![](images/modes/panel_12.png) |
| **13** | **3** | **35** | **100** | **644.8** | ![](images/modes/panel_13.png) |
| 14 | 3 | 35 | 150 | 255.5 | ![](images/modes/panel_14.png) |
| 15 | 3 | 35 | 200 | 132.4 | ![](images/modes/panel_15.png) |
| 16 | 3 | 45 | 100 | 603.7 | ![](images/modes/panel_16.png) |
| 17 | 3 | 45 | 150 | 259.3 | ![](images/modes/panel_17.png) |
| 18 | 3 | 45 | 200 | 133.3 | ![](images/modes/panel_18.png) |
| 19 | 4 | 25 | 100 | 396.8 | ![](images/modes/panel_19.png) |
| 20 | 4 | 25 | 150 | 286.9 | ![](images/modes/panel_20.png) |
| 21 | 4 | 25 | 200 | 224.4 | ![](images/modes/panel_21.png) |
| **22** | **4** | **35** | **100** | **745.4** | ![](images/modes/panel_22.png) |
| 23 | 4 | 35 | 150 | 528.5 | ![](images/modes/panel_23.png) |
| 24 | 4 | 35 | 200 | 284.8 | ![](images/modes/panel_24.png) |
| 25 | 4 | 45 | 100 | 655.9 | ![](images/modes/panel_25.png) |
| 26 | 4 | 45 | 150 | 540.1 | ![](images/modes/panel_26.png) |
| 27 | 4 | 45 | 200 | 286.6 | ![](images/modes/panel_27.png) |

</details>

---

## Response-surface models (RSM + ANOVA)

Three full-quadratic response surfaces fitted by ordinary least squares against the 27 simulation points, one per response (*P*ᶜʳ, Mass, *P*ᶜʳ/Mass). Coded factors *T* = (*t* − 3)/1, *H* = (*h* − 35)/10, *B* = (*b* − 150)/50.

### Model adequacy

<!-- These three PNGs come straight from MATLAB's adequacy_*.png outputs -->
![Adequacy — Pcr](images/rsm/adequacy_Pcr.png)
![Adequacy — Mass](images/rsm/adequacy_Mass.png)
![Adequacy — Pcr/Mass ratio](images/rsm/adequacy_Ratio.png)

### Response surfaces

<!-- These come from MATLAB's surface_*.png outputs -->
![Pcr surfaces](images/rsm/surface_Pcr.png)
![Pcr/Mass surfaces](images/rsm/surface_Ratio.png)

### Fitted polynomial (Pcr, coded factors)

```
Pcr = 321.1 + 159.3·T + 48.73·H − 152.2·B
    + 46.05·T·H − 38.14·T·B − 39.34·H·B
    − 25.39·T² − 59.99·H² + 35.71·B²
```

R² = 0.923 ·  Adjusted R² = 0.882 ·  RMSE = 70.57 kN ·  overall *p* = 9.5 × 10⁻⁸

Significant terms at α = 0.05: *T*, *H*, *B*, *T·H* (with *H*² borderline at *p* = 0.053).

---

## Pareto front

15 of the 27 configurations are non-dominated under the joint objective of maximising *P*ᶜʳ and minimising mass.

<!-- pareto_front.png from MATLAB -->
![Pareto front](images/rsm/pareto_front.png)

The Pareto front separates a load-critical knee (Panel 22, top right) from a strength-to-weight knee (Panel 13). A continuous RSM grid search across the bounded design space locates the load-maximising optimum at *t* = 4.00 mm, *h* = 44.33 mm, *b* = 100 mm (predicted *P*ᶜʳ = 754.0 kN, 27 % heavier than Panel 13).

---

## Repository layout

```
.
├── README.md                              ← this file
├── thesis/
│   └── Thesis_v5.docx                     ← final thesis
├── matlab/
│   └── Stiffened_Panel_RSM_ANOVA.m        ← RSM + ANOVA + Pareto
├── results/
│   ├── RSM_ANOVA_log.txt                  ← full MATLAB console log
│   └── RSM_dataset_and_fit.csv            ← 27 rows + fitted values
├── images/
│   ├── geometry/                          ← CAD screenshots
│   ├── mesh/                              ← mesh + convergence screenshots
│   ├── modes/                             ← panel_01.png … panel_27.png
│   └── rsm/                               ← MATLAB plot outputs
└── docs/
    ├── Response_to_expert.docx            ← OLS-derivation Q&A
    └── README_video.docx                  ← walkthrough video companion
```

---

## Reproducing the analysis

Requirements: MATLAB R2026a with the Statistics and Machine Learning Toolbox; ANSYS Mechanical 2024 R1 (only needed to regenerate the FE data — the 27 results are embedded in the MATLAB script).

```matlab
>> cd matlab
>> Stiffened_Panel_RSM_ANOVA
```

Press F5. The script writes all outputs to `RSM_ANOVA_Results/` in the current working directory. A walkthrough video and a written companion (`docs/README_video.docx`) explain each section step by step.

---

## Author

**Mohammad Haris**


---

