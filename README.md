# Gas Operations Field BI

## Business Context
A natural gas distribution company in Colombia manages field technician operations
across two planning centers covering Bogota and the Cundinamarca/Boyaca region.
This project analyzes 7,643 service orders from December 2025 to February 2026
to identify effectiveness drivers and distinguish systemic failures from operational ones.

**Central business question:**
> What operational and territorial factors explain non-effectiveness in field
> service orders, and what decisions should leadership make?

---

## Tools & Technologies
- **SQL** — Business intelligence queries across two executive perspectives (DB Browser for SQLite)
- **Python** — Exploratory analysis, visualizations and automated PDF report (Pandas, Matplotlib, Seaborn, fpdf2)
- **Power BI** — Executive dashboard with dual leadership perspective

---

## Project Structure
```
Gas-operations-field-BI/
├── Data/
│   └── data_source.md
├── PowerBI/
│   └── placeholder.md
├── Python/
│   ├── Gas_operation_analysis.ipynb
│   ├── efectividad_centro.png
│   ├── efectividad_mensual.png
│   ├── efectividad_mercado.png
│   ├── efectividad_servicio.png
│   └── executive_dashboard.png
├── Reports/
│   └── Gas_operation_executive_report.pdf
├── SQL/
│   └── Gas_Operations_Field_B.sql
└── README.md
```

---

## Key Findings

### Director of Operations Perspective
| Factor | Finding |
|--------|---------|
| Planning centers | Center 2401 outperforms 1501 by 12.7 points (75.49% vs 62.83%) |
| Monthly trend | Steady decline Dec 2025 (67.4%) to Feb 2026 (63.4%) |
| Technician performance | 38-point spread in Bogota vs 24-point spread in Cundinamarca/Boyaca |
| Service type | Deviation visits show 52.8% effectiveness - users not notified in advance |

### General Manager Perspective
| Factor | Finding |
|--------|---------|
| Municipality | Bogota has worst effectiveness (62.46%) vs rural municipalities (up to 89.3%) |
| Market segment | Industrial Non-Regulated leads (83.0%) - well-scheduled visits |
| Systemic vs operational | Pre-suspension and deviation orders reflect distribution company process failures |
| Technician ranking | Volume alone does not predict effectiveness |

---

## Key Distinction - Systemic vs Operational Non-Effectiveness

A critical finding of this project is the separation of non-effectiveness into two categories:

**Systemic** (caused by distribution company processes):
- Deviation visit orders where users are not notified (52.8% effectiveness)
- Pre-suspension reconnections (16.2% effectiveness)
- Temporary suspension orders incorrectly generated (26.8% effectiveness)

**Operational** (manageable by field team):
- Repair and maintenance services below benchmark
- Individual technician performance gaps in Center 1501

This distinction is essential for accurate performance measurement and fair evaluation
of the field team.

---

## Strategic Recommendations

IMMEDIATE - Revert operational process changes from Dec 2025 that caused the 4-point decline.

IMMEDIATE - Classify non-effectiveness by cause to separate systemic from operational failures.

SHORT TERM - Implement user pre-notification protocol for deviation visits (24-48 hours prior).

SHORT TERM - Design individual improvement plans for technicians below 55% in Center 1501.

MEDIUM TERM - Differentiated territorial strategy for Bogota: visible technician ID, confirmation calls, immediate rescheduling.

---

## Executive Dashboard
*(Power BI dashboard screenshots - coming soon)*

---

## Automated Report
This project includes a Python script that automatically generates a full executive
PDF report combining KPIs, findings and recommendations.

---

## Confidentiality Notice
This dataset comes from a real SAP export. All technician names, company names,
and internal work order nomenclature have been removed or anonymized in public
deliverables. The dataset is not included in this repository.

---

*Project by Daniel Esquivel | BI Analyst Portfolio*
*Tools: SQL - Python - Power BI*
