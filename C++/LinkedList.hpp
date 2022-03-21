/************************
 * Linked List HPP File *
 * Author: Ben Capeloto *
 *      4/26/2020       *
 ************************/

#ifndef LinkedList_HPP
#define LinkedList_HPP

#include <string>
#include <iostream>


using namespace std;

struct LLnode
{
    int LLkey;
    LLnode* next;
};

class LinkedList
{
    private:
        LLnode* head; //head pointer
    public:
        LinkedList();//constructor
        void LLinsert(int id);//insert function
        LLnode* LLsearch(int id);//search function
        void LLprintPath();
};

#endif