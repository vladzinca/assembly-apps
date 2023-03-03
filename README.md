# Assembly Apps

## 🏭 What is it?

This repository contains three [x86 assembly language](https://en.wikipedia.org/wiki/X86_assembly_language) code snippets I wrote back in December 2021.

They are called *Reversed One Time Pad*, *Ages* and *Columnar Transposition Cipher*.

I have a very basic understanding of how assembly code should be written, but writing something like this helped me in very surprising ways.

I also included in this project the `README` file I sent alongside the project back then, available in Romanian.

## ⚙️ How to run it?

1.  Clone this repository.
2.  Compile it using `make`. 
3.  Run automatic tests found in `input/` using `./checker`. This starts the `checker` (compiled during `make` from `checker.c`), which I received and did not write myself. The results will be printed in `output/` and compared to those found in `ref/`.
4.  Enjoy!

## 🤓 What do they do exactly?

### Reversed One Time Pad

```c
void rotp(char *ciphertext, char *plaintext, char *key, int len)
```

The code for this is found in `rotp.asm`.

This app reads from an input file:

```
len
plaintext
key
```

Afterwards, it calculates `ciphertext` to be the XOR operation between `plaintext` and `key` reversed, as follows: `ciphertext[i] = plain[i] ^ key[len - i - 1]`.

### Ages

```c
void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages)
```

The code for this is found in `ages.asm`.

A `my_date` is a struct containing two shorts and an int (day, month, year). Imagine it like this:

```c
struct my_date
{
  short day;
  short month;
  int year;
} __attribute__((packed));
```

The program reads from an input file structured like this:

```
len
present
dates
```

When it's done, it calculates the ages `len` people born on the dates found in `dates` have, considering the current day is `present`.

### Columnar Transposition Cipher

```c
void columnar_transposition(int key[], char *haystack, char *ciphertext)
```

This is a bit harder to conceptually grasp.

The code for this is found in `columnar.asm`.

It reads from an input file like the following:

```
len_plaintext len_key
plaintext
key
```

It encrypts the text found in `haystack` using `key` and puts the result in `ciphertext`.

![columnar](https://user-images.githubusercontent.com/74200913/222796336-f68995e1-69e7-43a6-9858-ee0d654fe957.png)

The way it does this is by creating a matrix, on whose first line we place the `key` (in the image, "cheie").

Then, on the other rows, it spells the text found in `haystack` (in the image, "Hai sa dam mana cu mana!"), stopping at the column `len_key - 1` and continuing on the next row.

Afterwards, it sorts the columns by lexicographical order of the `key` element present on each column, and the encrypted `ciphertext` is nothing but the characters on every column, in the new column order.

```
Result:
After first column: Ha  a
After second column: Ha  aidaua
After third column: Ha  aidauasmam
After fourth column: Ha  aidauasmama mcn
After fifth column: Ha  aidauasmama mcn an !
```

## 🧙 How does it *really* work?

It might look like magic, but when you take the veil of high-level languages off, this is how computers really work.

Writing assembly code is nothing but challenging: you only have registers, some basic arithmetic and jumps, code is very hard to debug and maintain and the brainpower needed is huge for the simplest of things. No wonder most code today is not written in assembly!

However, it was a surprisingly useful experience, for two reasons: sometimes you might find yourself needing to read an assembly file, and without a bit of training you simply won't make the cut. Secondly, it really helps you write better code. Nowadays, when I write code, I also take into consideration what assembly code the code I write would compile to, and this I would argue helps designing speedy applications as much as complexity analysis.

## 🤔 Did you know?

A bit unrelated, but it's fascinating that, at the time of writing, Assembly is still the 9th most popular language (it's not one language *per se*, but rather a number of languages) on the TIOBE Index.
