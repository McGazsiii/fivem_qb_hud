# DLRMS HUD for FiveM (QBCore Version)

A rewritten version of the DLRMS HUD for FiveM, converted from the ESX framework to **QBCore** with additional features and improvements.

---

## 🌟 Features

* **Smart Alert System:**
  * Flashes red when **Health** or **Armor** falls to **50% or below**.
  * Flashes red when **Hunger** or **Thirst** falls to **25% or below**.
  * To keep the UI clean and avoid annoying players, the alert system turns off when Armor drops to **0**.

* **Dynamic Vehicle Layout:**
  * When entering a vehicle, the **Stamina** indicator automatically hides.
  * The **Hunger** and **Thirst** indicators smoothly reposition above the Health and Armor bars.

* **Dynamic Stamina Icons:**
  * The stamina icon adapts dynamically depending on player context:
    * **Swimming on surface:** Displays a swimming icon.
    * **Underwater:** Displays a lung/oxygen icon.

---

## 📦 Dependencies & Requirements

* [qb-core](https://github.com/qbcore-framework/qb-core)

*(If you are still using ESX status bridges, adjust dependencies accordingly)*

---
