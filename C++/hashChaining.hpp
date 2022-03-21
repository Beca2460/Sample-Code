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



using namespace std;

struct node
{
    int Hkey;
    struct node* next;
    node(int k) {Hkey = k; next = 0;}

};

class HashTable
{
    int tableSize = 40009;  // No. of buckets (linked lists)

    // Pointer to an array containing buckets
    node* *table;
public:
    int numOfcolision = 0;
    HashTable();  // Constructor
    ~HashTable();
    // inserts a key into hash table
    void insertItem(int key);

    // hash function to map values to key
    int hashFunction(int key);

    void printTable();
    int getNumOfCollision();

    node* searchItem(int key);
};

#endif
