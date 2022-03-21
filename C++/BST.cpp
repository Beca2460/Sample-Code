/************************
 *     BST CPP File     *
 * Author: Ben Capeloto *
 *      4/26/2020       *
 ************************/

#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include "BST.hpp"

using namespace std;

//Constructor
Tree::Tree(){
    this->root = NULL;
}

//Destructor
Tree::~Tree(){
    recursiveDestruct(root);
}

//Print helper function
void Tree::BSTprint(BSTnode* root, int space){
  // Base case
    if (root == NULL)
        return;

    // Increase distance between levels
    space += COUNT;

    // Process right child first
    BSTprint(root->right, space);

    // Print current node after space
    // count
    printf("\n");
    for (int i = COUNT; i < space; i++)
        printf(" ");
    printf("%d\n", root->BSTkey);

    // Process left child
    BSTprint(root->left, space);

}

//pretty print function
void Tree::prettyPrint(){
    BSTprint(root, 1);
}


//destructor helper
void Tree::recursiveDestruct(BSTnode* node){
    if(node == NULL){

  }else{
    recursiveDestruct(node->left);
    recursiveDestruct(node->right);
    delete node;
  }
  return;
}


//insert function
void Tree::BSTinsert(int id){
    BSTinserthelper(root, id);
}

//insert helper function
void Tree::BSTinserthelper(BSTnode* &node, int val){
    if (node ==NULL){
    BSTnode* T =new BSTnode(val);
    node = T;
  }else{
    if (val < node->BSTkey){
      BSTinserthelper(node->left, val);
    }else if (val > node->BSTkey){
      BSTinserthelper(node->right, val);
    }
  }
  return; 
}

//search helper function
BSTnode* Tree::BSTsearchhelper(BSTnode* node, int val){
    if(node == NULL){
        return node;
    }else if(node->BSTkey==val){
        return node;
    }else if(node->BSTkey>val){
        return BSTsearchhelper(node->left, val);
    }else{
        return BSTsearchhelper(node->right, val);
    }
}

//search function
BSTnode* Tree::BSTsearch(int id){
    return BSTsearchhelper(root, id);
}