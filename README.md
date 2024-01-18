#RISC Processor Implementation in VHDL

Introduction
This project presents the design and implementation of a custom Reduced Instruction Set Computing (RISC) processor, specifically a simplified version of the MIPS processor. The focus of this project is to provide a practical experience in computer architecture, emphasizing hands-on development and understanding of fundamental concepts in processor design.

The processor is a 32-bit implementation and supports a subset of the MIPS instruction set architecture (ISA). The key instructions implemented include the core MIPS instructions (lw, sw, add, bne) along with additional instructions (beq and nand) as part of a custom instruction set. The implementation is carried out using VHDL, a powerful hardware description language that enables the detailed modeling of digital systems.

Project Overview
The project's primary objective is to create a functional and efficient RISC processor that adheres to a subset of the MIPS ISA. The implementation is single-cycle, ensuring that each instruction is executed in one clock cycle, which simplifies the design and improves understanding of the fundamental operations.

Key Features
32-Bit Processor Architecture: Fully functional 32-bit RISC processor, capable of handling standard data types and operations.
Implemented Instructions: The processor supports lw, sw, add, bne, beq, and nand instructions, demonstrating fundamental load/store, arithmetic, and branch operations.
VHDL Implementation: The processor is designed using VHDL, allowing for precise control over the hardware structure and functionality.
Code Structure
The repository contains the VHDL source files for the processor, including the ALU, registers, and control unit.
A testbench is provided to demonstrate the functionality of the implemented instructions with examples.
Usage
Clone the Repository: Download the VHDL files to your local machine.
Simulation and Testing: Load the files into a VHDL simulator, such as ModelSim or GHDL, to run the testbench and observe the processor's behavior.
Modification and Extension: Users can modify the VHDL code to add new features or optimize existing ones as needed.
Conclusion
This RISC processor project demonstrates a fundamental approach to computer architecture and processor design. Through the implementation of a subset of the MIPS ISA and additional custom instructions, the project provides insights into the workings of a RISC processor, serving as a valuable educational tool for students and enthusiasts alike.
