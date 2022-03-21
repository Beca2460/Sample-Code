/************************
 *     Hash CPP File    *
 *       Chaining       *
 * Author: Ben Capeloto *
 *      4/26/2020       *
 ************************/

#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include<cstdlib>
#include<cstdio>
#include "hashChaining.hpp"
const int tableSize = 40009;

using namespace std;

 // Constructor
HashTable::HashTable(){
    table = new node *[tableSize]; //create new table of nodes the size of tableSize
    for (int i = 0; i < tableSize; i++)
      table[i] = 0; //fill the table with 0/NULL;
} 

//Destructor
HashTable::~HashTable(){
    for (int i = 0; i < tableSize; ++i)
	    {
                node* entry = table[i];//create pointer to table entries
                while (entry != NULL)
	        {
                    node* prev = entry;//go through and delete while pointer doesnt reach end
                    entry = entry->next;
                    delete prev;
                }
            }
            delete[] table; //delete the table itself
}

// Hash Function
int HashTable::hashFunction(int key){
    return key%tableSize;
}

//Insert Function
void HashTable::insertItem(int key){
     node* temp = new node(key); //create new hash node 
    int index = hashFunction(key); //find index for hash node
    
    if (table[index] == 0)  table[index] = temp; //if there is nothing at that index make pointer the index
    else {
      numOfcolision++;
      temp->next = table[index]; //else push temp into the linked list
      table[index] = temp;
    }
}

node* HashTable::searchItem(int key){
    int index = hashFunction(key); //find the index where the key will be
    if (table[index] == 0)  return 0; //if there is no index return 0 it wasn't found
    else {
      node* curr = table[index]; //else current node created at the index in the table that hash function lead to
      while (curr != NULL) { //go through the list
	if (curr->Hkey == key) return curr; //return the node we find with the right key
	else curr = curr->next;
      }
      return 0; //return 0 if not found
    }
}

void HashTable::printTable(){
     for (int i = 0; i < tableSize; i++) {
      if (table[i] != 0) {
	cout << "[" << i << "] ";
	node* curr = table[i];
	while (curr != 0) {
	  cout << "-> Key: " << curr->Hkey << " (#" << hashFunction(curr->Hkey)<< ")"; 	  
	  curr = curr->next;
	}
	cout << endl;
      }
      else {
	cout << "[" << i << "] -> Empty" << endl;
      }
    }
}




/***********************Code Graveyard*************************/


//Insert function

//  int hashKey = hashFunction(key); //get the hash value
//     node* prev = NULL; //Previous pointer points to nothing right now
//     node* enter = table[hashKey]; //Pointer for where the value is going to enter the hash table
//     while (enter != NULL){//see if there is space in the hash table
//         prev = enter;
//         enter = enter -> next;
//     }if(enter == NULL){//if there is space
//         enter = new node(key, value);
//         if(prev = NULL){//if no previous pointer
//             table[hashKey]=enter; //create the enter pointer
//         }else{
//             prev->next=enter;//previous points to enter
//         }
//     }else{
//         enter->value = value; 
//     }