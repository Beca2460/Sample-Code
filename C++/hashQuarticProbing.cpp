/************************
 *     Hash CPP File    *
 *    Quartic Probing    *
 * Author: Ben Capeloto *
 *      4/26/2020       *
 ************************/

#include <iostream>
#include <fstream>
#include <string>
#include <chrono>
#include <sstream>
#include <cstdlib>
#include <time.h>
#include <stdlib.h>
#include <math.h>
using namespace std;
using namespace std::chrono;

const int tableSize = 40009;


struct node
{
    int Hkey;
    struct node* next;
    node(int k) {Hkey = k; next = 0;}

};

class HashTable
{
  node* *table;
  

public:
  int numColisions=0;
  HashTable()
  {
    table = new node *[tableSize]; //create new table of nodes the size of tableSize
    for (int i = 0; i < tableSize; i++)
    table[i] = 0; //fill the table with 0/NULL;
  }

  ~HashTable() { 
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

//insert function
  void insert(int key)
  {
    node *temp = new node(key);//creat new pointer for the new node
    int index = hashFunction(key);//find index from key

    if (table[index] == 0)//if there is no pointer at the index put the new pointer there
      table[index] = temp;
    else
    {
      for (int i = (index+i^2) % tableSize; i != index; i = (i+1) % tableSize)
      {
        if (table[i] == 0)
        {
          table[i] = temp;
          return;
        }
        else if (table[i]->Hkey == key)
        {
          numColisions++;
        }
      }
      return;
    }
  }

  int hashFunction(int key){
      return key%tableSize;
  }


  node* searchItem(int key){
    int index = hashFunction(key);//find index of item
    if (table[index] == 0) //if nothing at index its not there
      return 0;
    else if (table[index]->Hkey == key) //if the index is the key
      return table[index];
    else
    {
      for (int i = (index + i^2) % tableSize; i != index; i = (i + 1) % tableSize)//linearly probe 
      {
        if (table[i] == 0)//if we reach an index that it isnt at but nothing is there it isnt in list
          return 0;
        else if (table[i]->Hkey == key) //once we find it
          return table[i];
      }
      return 0;
    }
  }

  void printTable(){
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
};


int main(int argc, char *argv[])
{
    srand(time(NULL));
    ifstream dataFile;
    string data; 
    int hashSize = 40000;
    float LLinsert[400];
    float LLsearch[400];

  HashTable hash;

    if (argc != 2)//check if the right number of arguments have been passed through command line
	{
		cerr << "Not enough arguments!" << endl;
		return 1;
	}
    dataFile.open(argv[1]);//open the data set based on command line argument
    ofstream outInsertA ("hashQuarticinsertB.txt");
    ofstream outSearchA ("hashQuarticsearchB.txt");
    ofstream collisions("QuarticCollisionsB.txt");
    if (!dataFile.is_open())//check if it opened correctly
	{
		cerr << "Could not open " << argv[1] << " for reading!" << endl;
		return 2;
	}
    int testData[40000];
    for(int i = 0; i<40000;i++){
        getline(dataFile,data,',');
        int key;
        key = stoi(data);
        testData[i]=key;
    }


    /******************LL INSERT TEST***************/
    for(int i=0; i<400; i++){
        int sampleSize = 100;//initialize sample size
        int level = i*100;
        float duration[100];
        for(int j =0;j<sampleSize;j++){ //while data is being pulled from data set
            auto startInsert = high_resolution_clock::now();//start the clock
            hash.insert(testData[(i)+level]); 
            auto stopInsert = high_resolution_clock::now();//stop the clock
            auto durationInsert = duration_cast<microseconds>(stopInsert - startInsert);//record the duration
            duration[j]=durationInsert.count();
            
        }
        collisions<<hash.numColisions<<endl;
        //hash.printTable();
        float sum;
        for(int k=0;k<99;k++) sum = sum+duration[k];
        LLinsert[i] = sum/100;
        //cout << "Average insert time taken by the "<<i<<"th"<< " Data set was " << LLinsert[i]<< " Nanoseconds." <<endl;
        outInsertA<<LLinsert[i]<<endl;
    }
    /**************END LL Insert Test****************/
    hash.printTable();

    /***************LL Search Test***************/
    for(int i=0; i<400; i++){
        int sampleSize = 100;//initialize sample size
        int searchVar = 100;
        int n = rand()%searchVar*i+1;
        float durationS[100];
        for(int j = 0; j<sampleSize; j++){ //while data is being pulled from data set
            auto startSearch = high_resolution_clock::now();//start the clock
            //LL Search
            hash.searchItem(testData[n]);
            auto stopSearch = high_resolution_clock::now();//stop the clock
            auto durationSearch = duration_cast<microseconds>(stopSearch - startSearch);//record the duration
            durationS[j]=durationSearch.count();
        }
        float sumS;
        for(int k=0;k<99;k++) sumS=sumS+durationS[k];
        LLsearch[i] = sumS/100;
        //cout << "Average search time taken by the "<<i<<"th"<< " Data set was " << LLsearch[i]<< " Nanoseconds." <<endl;
        outSearchA<<LLsearch[i]<<endl;
    }
    /************End LL Search Test*******************/

    outInsertA.close();
    outSearchA.close();
    collisions.close();
    dataFile.close();
    return 0;

    
}