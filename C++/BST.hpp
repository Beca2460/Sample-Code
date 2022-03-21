/************************
 *     BST HPP File     *
 * Author: Ben Capeloto *
 *      4/26/2020       *
 ************************/

#ifndef BST_HPP
#define BST_HPP
#define COUNT 10

#include <string>
#include <iostream>

using namespace std;

struct BSTnode //struct for BST
{
    int BSTkey;
    BSTnode *left;
    BSTnode *right;
    BSTnode() {BSTkey = -1; left = 0; right = 0;}
    BSTnode(int k) {BSTkey = k; left = 0; right = 0;}
    BSTnode(int k, BSTnode* l, BSTnode* r) {BSTkey = k; left = l; right = r;}
};

class Tree
{
    private:
        BSTnode* root; //BST root
    public:
        Tree(); //Constructor
        ~Tree(); //Destructor
        void BSTinsert(int id);
        void BSTinserthelper(BSTnode* &node, int val);
        BSTnode* BSTsearchhelper(BSTnode* root, int val);
        BSTnode* BSTsearch(int id);
        void BSTprint(BSTnode* root, int space);
        void recursiveDestruct(BSTnode* node); 
        void prettyPrint();

};



#endif