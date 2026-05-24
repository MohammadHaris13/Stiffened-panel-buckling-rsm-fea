# Stiffened Panel Buckling Optimisation using RSM and FEA

Parametric finite element and response surface optimisation of Aluminium 6061-T6 stiffened panels subjected to uniform axial compression.

The project combines:

- ANSYS Mechanical 2024 R1
- MATLAB R2026a
- Design of Experiments (DOE)
- Response Surface Methodology (RSM)
- ANOVA
- Pareto optimisation

to investigate the effect of stiffener geometry on critical buckling load ($P_{cr}$), structural mass, and strength-to-weight ratio ($P_{cr}/\text{Mass}$).

---

## Project Objectives

- Maximise buckling resistance
- Minimise structural mass
- Identify Pareto-optimal designs
- Develop surrogate predictive models
- Reduce repeated FEA computation time

---

## Software

| Software | Purpose |
|---|---|
| ANSYS Mechanical 2024 R1 | Linear eigenvalue buckling analysis |
| ANSYS SpaceClaim | Parametric CAD modelling |
| MATLAB R2020a | RSM fitting, ANOVA, optimisation |
| Excel / CSV | DOE data handling |

---

## Geometry

Flat aluminium plate stiffened using longitudinal blade stiffeners welded along the full length.

### Base Plate

| Parameter | Value |
|---|---|
| Plate length | 1000 mm |
| Plate width | 600 mm |
| Material | Aluminium 6061-T6 |

### Design Variables

Three geometric variables were investigated using a $3^3$ full-factorial DOE.

| Variable | Symbol | Levels |
|---|---|---|
| Skin thickness | $t$ (mm) | 2, 3, 4 |
| Stiffener height | $h$ (mm) | 25, 35, 45 |
| Stiffener spacing | $b$ (mm) | 100, 150, 200 |

### Stiffener Count

| Spacing $b$ | Number of stiffeners |
|---|---|
| 100 mm | 5 |
| 150 mm | 3 |
| 200 mm | 2 |

### CAD Geometry

![CAD view 1](https://github.com/user-attachments/assets/33a63e6e-e92e-4e1f-a4c5-773e44a0cc31)
![CAD view 2](https://github.com/user-attachments/assets/416d6d3c-8cff-4e6d-bd0b-304985bdd71e)

---

## Material Properties

| Property | Value |
|---|---|
| Young's modulus | 68.9 GPa |
| Poisson's ratio | 0.33 |
| Density | 2700 kg/m³ |
| Yield strength | 276 MPa |

---

## Finite Element Analysis

Linear eigenvalue buckling simulations were performed in ANSYS Mechanical 2024 R1.

### Analysis Features

- Shell element formulation
- Parametric geometry workflow
- Linear eigenvalue buckling extraction
- Uniform axial compressive loading
- Automated DOE workflow

### Boundary Conditions

- One longitudinal edge fixed
- Axial compressive load applied on opposite edge
- Shell body formulation used
- First buckling eigenmode extracted

---

## Meshing

The stiffened panel was discretised using shell elements.

| Feature | Description |
|---|---|
| Element type | Shell elements |
| Mesh method | Patch conforming |
| Refinement regions | Stiffener intersections |
| Solver | Sparse direct solver |

![Global mesh](https://github.com/user-attachments/assets/dbb91eb4-3952-47cc-9247-986bb6e299fb)

### Mesh Convergence Study

A mesh convergence study was performed by progressively refining element size while monitoring the buckling eigenvalue, critical buckling load ($P_{cr}$), and percentage variation between refinements.

| Element Size (mm) | Eigenvalue $\lambda_1$ | $P_{cr}$ (kN) | % Change | Observation |
|---|---|---|---|---|
| 20 | 261.73 | 261.73 | — | Baseline |
| 15 | 258.22 | 258.22 | 1.34% | Refining |
| 10 | 255.52 | 255.52 | 1.05% | **Selected** |
| 7  | 254.32 | 254.32 | 0.47% | Converged |
| 5  | 253.63 | 253.63 | 0.27% | Fully converged |

![Convergence plot](https://github.com/user-attachments/assets/4da390d6-0f46-4326-82ff-95eb797ad097)

| 20 mm | 15 mm | 10 mm |
|---|---|---|
| ![20mm](https://github.com/user-attachments/assets/58432462-57cb-4d1a-9f07-cf90a2ef7752) | ![15mm](https://github.com/user-attachments/assets/018b42f9-6b86-4d8c-956d-c7b8656850ea) | ![10mm](https://github.com/user-attachments/assets/27a9168e-f425-4485-9680-f329f6065aa2) |

| 7 mm | 5 mm |
|---|---|
| ![7mm](https://github.com/user-attachments/assets/6f06bbee-267d-4438-92d5-f402640f3ebf) | ![5mm](https://github.com/user-attachments/assets/a50f74da-6073-408a-b9fa-971be6ce73e3) |

The **10 mm** element size was selected for all DOE simulations because the change in $P_{cr}$ reduced to approximately 1%, computational cost remained reasonable, and numerical stability was maintained. Further refinement produced only marginal improvement at significantly higher cost.

---

## Buckling Mode Shapes

Selected mode shape contours across panel configurations:

![Mode 1](https://github.com/user-attachments/assets/c6891cd1-6e47-4f49-867d-eb895859b644)
![Mode 2](https://github.com/user-attachments/assets/704a26b1-87d3-4bea-9068-7720cd456d76)
![Mode 3](https://github.com/user-attachments/assets/74155027-f738-4ead-ace0-b671a9094e03)
![Mode 4](https://github.com/user-attachments/assets/d53453ff-215a-4c2b-a7e9-8151b3553a1d)
![Mode 5](https://github.com/user-attachments/assets/b632af67-3cd5-4206-9fed-16b18c23d17f)
![Mode 6](https://github.com/user-attachments/assets/b3f629ed-41c3-4146-98ff-6bb4a3b379bc)
![Mode 7](https://github.com/user-attachments/assets/160ffd36-6fde-4504-b4de-55158c616462)
![Mode 8](https://github.com/user-attachments/assets/8d69cc0f-3ea4-4834-9dce-647ae2630103)
![Mode 9](https://github.com/user-attachments/assets/bf790f93-656d-460a-820a-76bc3fc34568)
![Mode 10](https://github.com/user-attachments/assets/370f7fe5-6619-4c29-906c-1fdc9b4ba0da)
![Mode 11](https://github.com/user-attachments/assets/1d1a0808-5cc1-4a37-aee2-2c18592345e7)
![Mode 12](https://github.com/user-attachments/assets/f488f9bf-df35-40ce-8300-fcab825c8343)
![Mode 13](https://github.com/user-attachments/assets/f471f076-7ca0-4ed4-bd58-d051bf60a8cb)
![Mode 14](https://github.com/user-attachments/assets/7f7dbe46-6d60-4576-a329-dc51c0bc2f18)
![Mode 15](https://github.com/user-attachments/assets/4925740c-a194-4286-99ae-640e591f4206)
![Mode 16](https://github.com/user-attachments/assets/bd56f582-cac6-4443-a5d0-1a8bb3896d4e)
![Mode 17](https://github.com/user-attachments/assets/18fae580-08c8-48ca-a21f-6143f5eeb811)
![Mode 18](https://github.com/user-attachments/assets/1799a168-3695-4065-97ad-b7e5811f00b3)
![Mode 19](https://github.com/user-attachments/assets/7c201911-18ae-4581-9828-f00bb8535978)
![Mode 20](https://github.com/user-attachments/assets/78883b2f-7d10-4fed-9128-35015a9566d3)
![Mode 21](https://github.com/user-attachments/assets/ddb3340e-cb05-42ba-ad9c-1d0da1d6a083)
![Mode 22](https://github.com/user-attachments/assets/301e0436-db6b-4c8c-a2dd-3c455254e1a7)
![Mode 23](https://github.com/user-attachments/assets/7cd4d815-c957-4350-9bf6-80665c482be5)
![Mode 24](https://github.com/user-attachments/assets/1a511e56-c2d2-4ead-949c-450ec16aa7ef)
![Mode 25](https://github.com/user-attachments/assets/c6d02f88-4f59-49a1-b2e9-0ce5b8086cc6)
![Mode 26](https://github.com/user-attachments/assets/0ce5081a-8c6b-4a14-bda9-6a340f31ade6)
![Mode 27](https://github.com/user-attachments/assets/cd0acd7c-f784-4f8a-b260-228e1ab80a19)

---

## Design of Experiments

A $3^3$ full-factorial DOE was used, yielding **27 panel configurations**.

### DOE Dataset

| Panel | $t$ (mm) | $h$ (mm) | $b$ (mm) | Mass (kg) | $P_{cr}$ (kN) | $P_{cr}$/Mass (kN/kg) |
|---|---|---|---|---|---|---|
| 1  | 2 | 25 | 100 | 3.92 | 43.76  | 11.16 |
| 2  | 2 | 25 | 150 | 4.01 | 45.21  | 11.27 |
| 3  | 2 | 25 | 200 | 4.12 | 46.84  | 11.37 |
| 4  | 2 | 35 | 100 | 4.28 | 87.54  | 20.45 |
| 5  | 2 | 35 | 150 | 4.39 | 89.61  | 20.41 |
| 6  | 2 | 35 | 200 | 4.51 | 91.08  | 20.20 |
| 7  | 2 | 45 | 100 | 4.92 | 218.34 | 44.38 |
| 8  | 2 | 45 | 150 | 5.03 | 226.71 | 45.07 |
| 9  | 2 | 45 | 200 | 5.17 | 236.02 | 45.65 |
| 10 | 3 | 25 | 100 | 5.42 | 132.26 | 24.40 |
| 11 | 3 | 25 | 150 | 5.53 | 131.87 | 23.85 |
| 12 | 3 | 25 | 200 | 5.61 | 130.54 | 23.27 |
| 13 | 3 | 35 | 100 | 6.81 | 644.80 | 94.58 |
| 14 | 3 | 35 | 150 | 7.07 | 603.42 | 85.35 |
| 15 | 3 | 35 | 200 | 7.18 | 529.11 | 73.69 |
| 16 | 3 | 45 | 100 | 7.30 | 395.82 | 54.22 |
| 17 | 3 | 45 | 150 | 7.41 | 287.94 | 38.86 |
| 18 | 3 | 45 | 200 | 7.53 | 224.67 | 29.84 |
| 19 | 4 | 25 | 100 | 7.12 | 287.14 | 40.33 |
| 20 | 4 | 25 | 150 | 7.23 | 284.01 | 39.28 |
| 21 | 4 | 25 | 200 | 7.34 | 286.63 | 39.05 |
| 22 | 4 | 35 | 100 | 8.16 | 540.33 | 66.22 |
| 23 | 4 | 35 | 150 | 8.28 | 529.41 | 63.94 |
| 24 | 4 | 35 | 200 | 8.41 | 507.62 | 60.36 |
| 25 | 4 | 45 | 100 | 8.56 | 754.00 | 88.08 |
| 26 | 4 | 45 | 150 | 8.64 | 680.13 | 78.72 |
| 27 | 4 | 45 | 200 | 8.71 | 655.08 | 75.21 |

### CSV Column Reference

| Column | Description |
|---|---|
| `Panel_ID` | Panel configuration number |
| `Thickness_mm` | Skin thickness |
| `Height_mm` | Stiffener height |
| `Spacing_mm` | Stiffener spacing |
| `Mass_kg` | Structural mass |
| `Pcr_kN` | Critical buckling load |
| `Ratio_kN_per_kg` | Strength-to-weight ratio |

---

## Response Surface Methodology

Second-order polynomial response surfaces were fitted in MATLAB R2020a for mass, critical buckling load, and strength-to-weight ratio.

### RSM Model Equation

$$Y = \beta_0 + \sum \beta_i x_i + \sum \beta_{ij} x_i x_j + \sum \beta_{ii} x_i^2$$

where $Y$ is the predicted response, $x_i$ are the design variables, and $\beta$ are the regression coefficients.

### Model Adequacy — Mass

| Metric | Value |
|---|---|
| $R^2$ | 1.000 |
| Residual behaviour | Random |
| Q-Q plot | Approximately normal |

The mass model shows near-perfect agreement between predicted and actual values.

![Mass adequacy plot](https://github.com/user-attachments/assets/46f3d5c5-8ae0-4a30-b920-66f824399a8e)

### Model Adequacy — Critical Buckling Load

| Metric | Value |
|---|---|
| $R^2$ | 0.923 |
| Residual behaviour | Acceptable |
| Q-Q plot | Near-normal |

The $P_{cr}$ model captures the overall buckling trend with good predictive accuracy.

![Pcr adequacy plot](https://github.com/user-attachments/assets/fdcf899d-07bc-4029-8741-256ecad2d4b2)

### Model Adequacy — Strength-to-Weight Ratio

| Metric | Value |
|---|---|
| $R^2$ | 0.890 |
| Residual behaviour | Acceptable |
| Q-Q plot | Approximately normal |

The strength-to-weight model demonstrates acceptable predictive capability for optimisation studies.

![Ratio adequacy plot](https://github.com/user-attachments/assets/ff86d56f-8f4f-4c02-babb-5571ef0d83b6)

---

## ANOVA Analysis

### Critical Buckling Load

Plate thickness ($t$) and stiffener spacing ($b$) are the most influential parameters. The interaction between thickness and stiffener height ($t:h$) is also statistically significant.

| Metric | Value |
|---|---|
| $R^2$ | 0.9227 |
| Adjusted $R^2$ | 0.8818 |
| RMSE | 70.57 |
| Model p-value | $9.5 \times 10^{-8}$ |
| Significant terms | $t$, $h$, $b$, $t:h$ |

![Pcr response surface](https://github.com/user-attachments/assets/fda21d70-fa7f-4a80-9926-a1668aff8d20)

### Strength-to-Weight Ratio

Thickness, stiffener height, and spacing all significantly influence structural efficiency. Smaller stiffener spacing improves the ratio considerably.

| Metric | Value |
|---|---|
| $R^2$ | 0.8898 |
| Adjusted $R^2$ | 0.8314 |
| RMSE | 9.834 |
| Model p-value | $1.74 \times 10^{-6}$ |
| Significant terms | $t$, $h$, $b$ |

![Ratio response surface](https://github.com/user-attachments/assets/3a1829d4-8874-457d-90fe-8680fdcac77e)

---

## Response Surfaces

### Critical Buckling Load

| Parameter trend | Effect on $P_{cr}$ |
|---|---|
| Higher thickness | Strong increase |
| Larger spacing | Reduction |
| Higher stiffener height | Moderate increase |
| Thickness–height interaction | Significant |

![Pcr surface](https://github.com/user-attachments/assets/d685c826-7922-4b6a-90d1-20765038953b)

### Strength-to-Weight Ratio

| Parameter trend | Effect on $P_{cr}$/Mass |
|---|---|
| Higher thickness | Improves initially, then decreases |
| Smaller spacing | Strong improvement |
| Higher stiffener height | Moderate improvement |

![Ratio surface](https://github.com/user-attachments/assets/545a6c76-fcc2-49a9-a63e-1873a5a0ccff)

---

## Pareto Optimisation

Multi-objective optimisation identifies panel configurations that maximise $P_{cr}$ while minimising structural mass.

### Best Simulated Configuration

| Parameter | Value |
|---|---|
| Panel ID | 13 |
| Thickness $t$ | 3 mm |
| Stiffener height $h$ | 35 mm |
| Stiffener spacing $b$ | 100 mm |
| Critical buckling load | 644.8 kN |
| Mass | 6.817 kg |
| Strength-to-weight ratio | 94.58 kN/kg |

### RSM-Predicted Optimum

| Parameter | Value |
|---|---|
| Thickness $t$ | 4.00 mm |
| Stiffener height $h$ | 44.33 mm |
| Stiffener spacing $b$ | 100 mm |
| Predicted $P_{cr}$ | 754.0 kN |
| Predicted mass | 8.694 kg |
| Predicted $P_{cr}$/Mass | 89.56 kN/kg |

### Pareto-Optimal Panel IDs

1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 17, 22

![Pareto front](https://github.com/user-attachments/assets/6b07d226-8f68-4a73-b20f-9c127d5acd94)

---

## Engineering Conclusions

- Thickness is the most influential parameter affecting buckling strength
- Smaller stiffener spacing significantly improves stiffness
- Increasing stiffener height improves buckling resistance
- Excessive thickness increases mass disproportionately
- RSM successfully predicts structural behaviour with good accuracy
- Pareto optimisation identifies efficient lightweight configurations
- Surrogate modelling reduces repeated FEA computational cost

---

## Project Files

| File | Description |
|---|---|
| `DOE_27_Panels.csv` | Full 27-panel simulation dataset |
| `RSM_Model.m` | MATLAB response-surface fitting |
| `ANOVA_Analysis.m` | Statistical analysis |
| `Pareto_Optimisation.m` | Multi-objective optimisation |
| `ANSYS_Project.wbpj` | ANSYS Mechanical project |
| `README.md` | Project documentation |

---

## Future Work

- Nonlinear post-buckling analysis
- Composite stiffened panels
- Dynamic loading analysis
- Fatigue assessment
- Machine-learning surrogate models
- Genetic algorithm optimisation

---

## Author

**Mohammad Haris** — Mechanical Engineer | FEA & CFD Engineer

GitHub: [github.com/MohammadHaris13](https://github.com/MohammadHaris13)

---

*This project is intended for academic and research purposes.*
