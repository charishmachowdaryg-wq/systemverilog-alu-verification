# SystemVerilog ALU Design Verification Lab

## 📌 Overview

This repository contains an 8-bit Arithmetic Logic Unit (ALU) design and its functional verification environment developed using SystemVerilog. The project demonstrates fundamental Design Verification concepts including self-checking testbenches, scoreboard-based verification, functional coverage, and cross coverage to ensure correct ALU functionality.

---

## 📂 Project Included

### Arithmetic Logic Unit (ALU)

* 8-bit ALU design
* Addition operation
* Subtraction operation
* Multiplication operation
* Bitwise OR operation
* Valid signal-controlled output generation
* Self-checking verification environment
* Functional and cross coverage implementation

---

## 🧪 Verification Methodology

This project follows a structured verification approach:

* Directed stimulus generation using reusable testbench tasks
* Self-checking scoreboard for expected result generation
* Automatic PASS/FAIL result comparison
* Functional coverage collection for operands, operation codes, and valid signal
* Cross coverage between operation code and valid signal
* Corner-case verification using minimum and maximum operand values
* Waveform analysis for debugging and result validation

---

## 📌 ALU Behavior

The ALU performs operations based on the selected opcode when the `valid` signal is asserted.

| Opcode | Operation              |
| ------ | ---------------------- |
| 00     | Addition (A + B)       |
| 01     | Subtraction (A - B)    |
| 10     | Multiplication (A * B) |
| 11     | Bitwise OR (A | B)     |

### Valid Signal Behavior

* When `valid = 1`, the ALU executes the selected operation and produces the corresponding result.
* When `valid = 0`, the output result is forced to `8'h00` regardless of the opcode value.

---

## 🛠️ Tools Used

* SystemVerilog HDL
* EDA Playground (simulation platform)

---

## 📊 Simulation Results

The verification environment successfully validates:

* All supported ALU operations
* Valid and invalid transaction scenarios
* Corner-case operand values (`8'h00` and `8'hFF`)
* Functional coverage collection
* Cross coverage verification between operation code and valid signal
* Automatic result checking through a scoreboard-based reference model

Simulation output includes PASS/FAIL status for every test case along with detailed coverage statistics.

