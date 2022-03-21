/************************
 * Linked List CPP File *
 * Author: Ben Capeloto *
 *      4/26/2020       *
 ************************/

#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include "LinkedList.hpp"

using namespace std;


//Constructor
LinkedList::LinkedList(){
    head == NULL;
}

//insert
void LinkedList::LLinsert(int id)
{
    LLnode *NewNode;
    NewNode=new LLnode;
    NewNode->LLkey=id;
    NewNode->next=NULL;

    LLnode* EndNode;
    EndNode=head;

    if(EndNode == NULL)
       EndNode=NewNode;
    else
    {
        while(EndNode->next!=NULL)
            EndNode=EndNode->next;
        ///by now EndNode->Next is equal to null
        EndNode->next=NewNode;///so this is what you need

    }
}


//print List
void LinkedList::LLprintPath(){
  LLnode* temp = head;

  while(temp->next != NULL){
    cout<< temp->LLkey <<" -> ";
    temp = temp->next;
  }

  cout<<temp->LLkey<<endl;
}

LLnode* LinkedList::LLsearch(int id) {

    LLnode* ptr = head;
    while (ptr != NULL && ptr->LLkey != id)
    {
        ptr = ptr->next;
    }
    return ptr;
}



/***********************Code Graveyard for Potential resurection***************************/

/*From insert Function*/

//   //Check if head is Null
//   if(head == NULL){
//     head = new LLnode;
//     head->LLkey = id;
//     head->next = NULL;
//   }

//   // if list is not empty, look for prev and append our node there
//   else if(previous == NULL)
//   {
//       LLnode* newNode = new LLnode;
//       newNode->LLkey = id;
//       newNode->next = head;
//       head = newNode;
//   }

//   else{

//       LLnode* newNode = new LLnode;
//       newNode->LLkey = id;
//       newNode->next = previous->next;
//       previous->next = newNode;

//     }
// }