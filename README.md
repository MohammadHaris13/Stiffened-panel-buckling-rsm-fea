# Stiffened Panel Buckling Optimisation using RSM and FEA

Parametric finite element and response surface optimisation of Aluminium 6061-T6 stiffened panels subjected to uniform axial compression.

The project combines:

- ANSYS Mechanical 2024 R1
- MATLAB R2020a
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

![CAD Geometry](images/cad_geometry.png)

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

![Global Mesh](images/global_mesh.png)

---

# Local mesh refinement

![Local Mesh](images/local_mesh.png)

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

![Mesh Convergence](images/mesh_convergence.png)

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

![Buckling Mode](images/buckling_mode.png)

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
3 \times 3 \times 3 = 27 \text{ panel configurations}
\]

---

# DOE dataset

The project includes a complete dataset containing:

- Panel geometry
- Structural mass
- Critical buckling load
- Strength-to-weight ratio

## Dataset file

```text
DOE_27_Panels.csv
```

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

# DOE table

![DOE Table](images/doe_table.png)

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
