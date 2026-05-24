# Stiffened Panel Buckling Optimisation using RSM and FEA

Parametric finite element and response surface optimisation of Aluminium 6061-T6 stiffened panels subjected to uniform axial compression.

The project combines:

- ANSYS Mechanical 2024 R1
- MATLAB R2026a
- Design of Experiments (DOE)
- Response Surface Methodology (RSM)
- ANOVA
- Pareto optimisation

to investigate the effect of stiffener geometry on:

- Critical buckling load (\(P_{cr}\))
- Structural mass
- Strength-to-weight ratio (\(P_{cr}/\text{Mass}\))

---

# Project objectives

- Maximise buckling resistance
- Minimise structural mass
- Identify Pareto-optimal designs
- Develop surrogate predictive models
- Reduce repeated FEA computation time

---

# Software used

| Software | Purpose |
|---|---|
| ANSYS Mechanical 2024 R1 | Linear eigenvalue buckling analysis |
| ANSYS SpaceClaim | Parametric CAD modelling |
| MATLAB R2020a | RSM fitting, ANOVA, optimisation |
| Excel / CSV | DOE data handling |

---

# Geometry description

Flat aluminium plate stiffened using longitudinal blade stiffeners welded along the full length.

## Base geometry

| Parameter | Value |
|---|---|
| Plate length | 1000 mm |
| Plate width | 600 mm |
| Material | Aluminium 6061-T6 |

---

# Design variables

Three geometric variables were investigated using a \(3^3\) full-factorial DOE.

| Variable | Symbol | Levels |
|---|---|---|
| Skin thickness | \(t\) (mm) | 2, 3, 4 |
| Stiffener height | \(h\) (mm) | 25, 35, 45 |
| Stiffener spacing | \(b\) (mm) | 100, 150, 200 |

## Stiffener count

| Spacing \(b\) | Number of stiffeners |
|---|---|
| 100 mm | 5 |
| 150 mm | 3 |
| 200 mm | 2 |

---

# CAD geometry

<img width="1669" height="820" alt="Screenshot 2026-05-15 161712" src="https://github.com/user-attachments/assets/33a63e6e-e92e-4e1f-a4c5-773e44a0cc31" />
<img width="1600" height="838" alt="Screenshot 2026-05-15 161136" src="https://github.com/user-attachments/assets/416d6d3c-8cff-4e6d-bd0b-304985bdd71e" />


---

# Material properties

| Property | Value |
|---|---|
| Young's modulus | 68.9 GPa |
| Poisson ratio | 0.33 |
| Density | 2700 kg/m³ |
| Yield strength | 276 MPa |

---

# Finite Element Analysis (FEA)

Linear eigenvalue buckling simulations were performed in ANSYS Mechanical 2024 R1.

## Analysis features

- Shell element formulation
- Parametric geometry workflow
- Linear eigenvalue buckling extraction
- Uniform axial compressive loading
- Automated DOE workflow

---

# Boundary conditions

- One longitudinal edge fixed
- Axial compressive load applied on opposite edge
- Shell body formulation used
- First buckling eigenmode extracted

---

# Meshing strategy

The stiffened panel was discretised using shell elements.

## Mesh characteristics

| Feature | Description |
|---|---|
| Element type | Shell elements |
| Mesh method | Patch conforming |
| Refinement regions | Stiffener intersections |
| Solver | Sparse direct solver |

---

# Global mesh

<img width="1540" height="823" alt="Screenshot 2026-05-15 161822" src="https://github.com/user-attachments/assets/dbb91eb4-3952-47cc-9247-986bb6e299fb" />


---

# Local mesh refinement

<img width="1540" height="649" alt="Screenshot 2026-05-15 161909" src="https://github.com/user-attachments/assets/25793c3e-7678-4c89-9036-6c0127258c37" />


---

# Mesh convergence study

A mesh convergence study was performed to ensure mesh-independent buckling predictions.

The element size was progressively refined while monitoring:

- Buckling eigenvalue
- Critical buckling load (\(P_{cr}\))
- Percentage variation between refinements

---

# Mesh convergence results

| Element Size (mm) | Eigenvalue \(\lambda_1\) | \(P_{cr}\) (kN) | % Change | Observation |
|---|---|---|---|---|
| 20 | 261.73 | 261.73 | Baseline | Initial mesh |
| 15 | 258.22 | 258.22 | 1.34% | Refining |
| 10 | 255.52 | 255.52 | 1.05% | **Selected mesh** |
| 7 | 254.32 | 254.32 | 0.47% | Converged |
| 5 | 253.63 | 253.63 | 0.27% | Fully converged |

---

# Mesh convergence plot

<img width="491" height="138" alt="Screenshot 2026-05-14 124445" src="https://github.com/user-attachments/assets/4da390d6-0f46-4326-82ff-95eb797ad097" />
<img width="1920" height="1080" alt="20mm" src="https://github.com/user-attachments/assets/58432462-57cb-4d1a-9f07-cf90a2ef7752" />
<img width="1920" height="1080" alt="15mm" src="https://github.com/user-attachments/assets/018b42f9-6b86-4d8c-956d-c7b8656850ea" />
<img width="1920" height="1080" alt="10mm" src="https://github.com/user-attachments/assets/27a9168e-f425-4485-9680-f329f6065aa2" />
<img width="1920" height="1080" alt="7mm" src="https://github.com/user-attachments/assets/6f06bbee-267d-4438-92d5-f402640f3ebf" />
<img width="1920" height="1080" alt="5mm" src="https://github.com/user-attachments/assets/a50f74da-6073-408a-b9fa-971be6ce73e3" />


---

# Mesh selection

The 10 mm element size was selected for all DOE simulations because:

- The solution was close to convergence
- Change in \(P_{cr}\) reduced to approximately 1%
- Computational cost remained reasonable
- Numerical stability was maintained

Further refinement below 10 mm produced only marginal improvement while significantly increasing computational expense.

---

# Buckling mode shape

<img width="1920" height="1080" alt="27" src="https://github.com/user-attachments/assets/cd0acd7c-f784-4f8a-b260-228e1ab80a19" />
<img width="1920" height="1080" alt="26" src="https://github.com/user-attachments/assets/0ce5081a-8c6b-4a14-bda9-6a340f31ade6" />
<img width="1920" height="1080" alt="25" src="https://github.com/user-attachments/assets/c6d02f88-4f59-49a1-b2e9-0ce5b8086cc6" />
<img width="1920" height="1080" alt="24" src="https://github.com/user-attachments/assets/1a511e56-c2d2-4ead-949c-450ec16aa7ef" />
<img width="1920" height="1080" alt="23" src="https://github.com/user-attachments/assets/7cd4d815-c957-4350-9bf6-80665c482be5" />
<img width="1920" height="1080" alt="22" src="https://github.com/user-attachments/assets/301e0436-db6b-4c8c-a2dd-3c455254e1a7" />
<img width="1920" height="1080" alt="21" src="https://github.com/user-attachments/assets/ddb3340e-cb05-42ba-ad9c-1d0da1d6a083" />
<img width="1920" height="1080" alt="20" src="https://github.com/user-attachments/assets/78883b2f-7d10-4fed-9128-35015a9566d3" />
<img width="1920" height="1080" alt="19" src="https://github.com/user-attachments/assets/7c201911-18ae-4581-9828-f00bb8535978" />
<img width="1920" height="1080" alt="18" src="https://github.com/user-attachments/assets/1799a168-3695-4065-97ad-b7e5811f00b3" />
<img width="1920" height="1080" alt="17" src="https://github.com/user-attachments/assets/18fae580-08c8-48ca-a21f-6143f5eeb811" />
<img width="1920" height="1080" alt="16" src="https://github.com/user-attachments/assets/bd56f582-cac6-4443-a5d0-1a8bb3896d4e" />
<img width="1920" height="1080" alt="15" src="https://github.com/user-attachments/assets/4925740c-a194-4286-99ae-640e591f4206" />
<img width="1920" height="1080" alt="14" src="https://github.com/user-attachments/assets/7f7dbe46-6d60-4576-a329-dc51c0bc2f18" />
<img width="1920" height="1080" alt="13" src="https://github.com/user-attachments/assets/f471f076-7ca0-4ed4-bd58-d051bf60a8cb" />
<img width="1920" height="1080" alt="12" src="https://github.com/user-attachments/assets/f488f9bf-df35-40ce-8300-fcab825c8343" />
<img width="1920" height="1080" alt="11" src="https://github.com/user-attachments/assets/1d1a0808-5cc1-4a37-aee2-2c18592345e7" />
<img width="1920" height="1080" alt="10" src="https://github.com/user-attachments/assets/8d69cc0f-3ea4-4834-9dce-647ae2630103" />
<img width="1920" height="1080" alt="9" src="https://github.com/user-attachments/assets/bf790f93-656d-460a-820a-76bc3fc34568" />
<img width="1920" height="1080" alt="8" src="https://github.com/user-attachments/assets/370f7fe5-6619-4c29-906c-1fdc9b4ba0da" />
<img width="1920" height="1080" alt="7" src="https://github.com/user-attachments/assets/160ffd36-6fde-4504-b4de-55158c616462" />
<img width="1920" height="1080" alt="6" src="https://github.com/user-attachments/assets/b3f629ed-41c3-4146-98ff-6bb4a3b379bc" />
<img width="1920" height="1080" alt="5" src="https://github.com/user-attachments/assets/b632af67-3cd5-4206-9fed-16b18c23d17f" />
<img width="1920" height="1080" alt="4" src="https://github.com/user-attachments/assets/d53453ff-215a-4c2b-a7e9-8151b3553a1d" />
<img width="1920" height="1080" alt="3" src="https://github.com/user-attachments/assets/74155027-f738-4ead-ace0-b671a9094e03" />
<img width="1920" height="1080" alt="2" src="https://github.com/user-attachments/assets/704a26b1-87d3-4bea-9068-7720cd456d76" />
<img width="1920" height="1080" alt="1" src="https://github.com/user-attachments/assets/c6891cd1-6e47-4f49-867d-eb895859b644" />


---

# Design of Experiments (DOE)

A full-factorial DOE was used.

## DOE structure

| Parameter | Levels |
|---|---|
| Thickness \(t\) | 3 |
| Height \(h\) | 3 |
| Spacing \(b\) | 3 |

Total simulations:

\[
3^3 = 27 \text{ panel configurations}
\]
---

# DOE dataset

The project includes a complete dataset containing:

- Panel geometry
- Structural mass
- Critical buckling load
- Strength-to-weight ratio

---

# DOE dataset table

| Panel | t (mm) | h (mm) | b (mm) | Mass (kg) | Pcr (kN) | Pcr/Mass (kN/kg) |
|---|---|---|---|---|---|---|
| 1 | 2 | 25 | 100 | 3.92 | 43.76 | 11.16 |
| 2 | 2 | 25 | 150 | 4.01 | 45.21 | 11.27 |
| 3 | 2 | 25 | 200 | 4.12 | 46.84 | 11.37 |
| 4 | 2 | 35 | 100 | 4.28 | 87.54 | 20.45 |
| 5 | 2 | 35 | 150 | 4.39 | 89.61 | 20.41 |
| 6 | 2 | 35 | 200 | 4.51 | 91.08 | 20.20 |
| 7 | 2 | 45 | 100 | 4.92 | 218.34 | 44.38 |
| 8 | 2 | 45 | 150 | 5.03 | 226.71 | 45.07 |
| 9 | 2 | 45 | 200 | 5.17 | 236.02 | 45.65 |
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


---

# CSV dataset structure

| Column | Description |
|---|---|
| Panel_ID | Panel configuration number |
| Thickness_mm | Skin thickness |
| Height_mm | Stiffener height |
| Spacing_mm | Stiffener spacing |
| Mass_kg | Structural mass |
| Pcr_kN | Critical buckling load |
| Ratio_kN_per_kg | Strength-to-weight ratio |

---

# MATLAB workflow

Simulation results from ANSYS were exported to MATLAB R2020a for:

- Polynomial regression
- Response surface generation
- ANOVA
- Model adequacy checking
- Pareto optimisation
- Surface and contour plotting

---

# Response Surface Methodology (RSM)

Second-order polynomial response surfaces were fitted for:

- Mass
- Critical buckling load
- Strength-to-weight ratio

## General RSM equation

\[
Y = \beta_0 + \sum \beta_i x_i + \sum \beta_{ij} x_i x_j + \sum \beta_{ii} x_i^2
\]

where:

- \(Y\) = predicted response
- \(x_i\) = design variables
- \(\beta\) = regression coefficients

---

# Model adequacy — Mass

## Regression quality

| Metric | Value |
|---|---|
| \(R^2\) | 1.000 |
| Residual behaviour | Random |
| Q-Q plot | Approximately normal |

The mass model shows nearly perfect agreement between predicted and actual values.

![Mass Adequacy](images/adequacy_mass.png)

---

# Model adequacy — Critical buckling load

## Regression quality

| Metric | Value |
|---|---|
| \(R^2\) | 0.923 |
| Residual behaviour | Acceptable |
| Q-Q plot | Near-normal |

The \(P_{cr}\) model captures the overall buckling trend with good predictive accuracy.

![Pcr Adequacy](images/adequacy_pcr.png)

---

# Model adequacy — Strength-to-weight ratio

## Regression quality

| Metric | Value |
|---|---|
| \(R^2\) | 0.890 |
| Residual behaviour | Acceptable |
| Q-Q plot | Approximately normal |

The strength-to-weight model demonstrates acceptable predictive capability for optimisation studies.

![Ratio Adequacy](images/adequacy_ratio.png)

---

# ANOVA analysis

ANOVA was used to identify statistically significant design variables affecting structural behaviour.

---

# Significant observations

## Critical buckling load (\(P_{cr}\))

- Thickness strongly increases buckling resistance
- Reduced stiffener spacing improves stiffness
- Interaction between thickness and height is significant

## Mass

- Thickness and stiffener spacing dominate structural mass
- Mass model shows nearly linear behaviour

## Strength-to-weight ratio

- Best ratios occur at moderate thickness with low spacing
- Excessive thickness increases mass disproportionately

---

# ANOVA plots

## \(P_{cr}\) ANOVA

![Pcr ANOVA](images/anova_pcr.png)

---

## Mass ANOVA

![Mass ANOVA](images/anova_mass.png)

---

## Ratio ANOVA

![Ratio ANOVA](images/anova_ratio.png)

---

# Response surfaces — Critical buckling load

The response surfaces show:

- Increasing thickness significantly improves \(P_{cr}\)
- Lower stiffener spacing increases stiffness
- Larger stiffener height improves buckling resistance

![Pcr Response Surface](images/response_surface_pcr.png)

---

# Response surfaces — Strength-to-weight ratio

The strength-to-weight response surfaces indicate:

- Optimum designs occur at moderate mass
- Smaller spacing improves efficiency
- Excessive thickness reduces efficiency gains

![Ratio Response Surface](images/response_surface_ratio.png)

---

# Pareto optimisation

Multi-objective optimisation was performed to identify panel configurations balancing:

- Maximum buckling resistance
- Minimum structural mass

---

# Pareto front

![Pareto Front](images/pareto_front.png)

---

# Best simulated configuration

| Parameter | Value |
|---|---|
| Panel | 13 |
| Thickness \(t\) | 3 mm |
| Height \(h\) | 35 mm |
| Spacing \(b\) | 100 mm |
| Mass | 6.81 kg |
| \(P_{cr}\) | 644.8 kN |
| \(P_{cr}/\text{Mass}\) | 94.58 kN/kg |

This configuration produced the best strength-to-weight ratio among all simulated panels.

---

# RSM-predicted optimum

| Parameter | Value |
|---|---|
| Thickness \(t\) | 4.00 mm |
| Height \(h\) | 44.33 mm |
| Spacing \(b\) | 100 mm |
| Predicted \(P_{cr}\) | 754.0 kN |

The response surface predicts improved buckling performance near the upper design boundary.

---

# Engineering conclusions

- Thickness is the most influential parameter affecting buckling strength
- Smaller stiffener spacing significantly improves stiffness
- Increasing stiffener height improves buckling resistance
- Excessive thickness increases mass disproportionately
- RSM successfully predicts structural behaviour with good accuracy
- Pareto optimisation identifies efficient lightweight configurations
- Surrogate modelling reduces repeated FEA computational cost

---

# Included project files

| File | Description |
|---|---|
| `DOE_27_Panels.csv` | Full 27-panel simulation dataset |
| `RSM_Model.m` | MATLAB response-surface fitting |
| `ANOVA_Analysis.m` | Statistical analysis |
| `Pareto_Optimisation.m` | Multi-objective optimisation |
| `ANSYS_Project.wbpj` | ANSYS Mechanical project |
| `README.md` | Project documentation |

---

# Future work

- Nonlinear post-buckling analysis
- Composite stiffened panels
- Dynamic loading analysis
- Fatigue assessment
- Machine-learning surrogate models
- Genetic algorithm optimisation

---

# Author

**Mohammad Haris**  
Mechanical Engineer | FEA & CFD Engineer

GitHub:  
https://github.com/MohammadHaris13

---

# License

This project is intended for academic and research purposes.
