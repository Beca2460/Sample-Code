/************************
 *     Hash HPP File    *
 * Author: Ben Capeloto *
 *      4/26/2020       *
 ************************/

#ifndef HASH_HPP
#define HASH_HPP

#include <string>
#include <math.h>
#include<iostream>
#include<cstdlib>
#include<cstdio>
const int tableSize = 40009;


using namespace std;

struct node
{
    int Hkey;
    int value;
    struct node* next;

    node() {Hkey = 0; value = 0; next = 0;}
    node(int k, int v) {Hkey = k; value = v; next = 0;}
    node() {}
};

class HashTable
{
    int tableSize;  // No. of buckets (linked lists)

    // Pointer to an array containing buckets
    node* *table;
    int numOfcolision = 0;
public:
    HashTable();  // Constructor
    ~HashTable();
    // inserts a key into hash table
    void insertItem(int key, int value);

    // hash function to map values to key
    unsigned int hashFunction(int key);

    void printTable();
    int getNumOfCollision();

    node* searchItem(int key);
};

#endif
