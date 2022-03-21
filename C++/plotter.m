%% Plots for CSCI 2270 Final Project
%Author: Ben Capeloto

%% House Keeping
clear all
clc
close all

%% BST
dataInsertA = readmatrix('BSTinsertA.txt');
dataSearchA = readmatrix('BSTSearchA.txt');
dataInsertB = readmatrix('BSTinsertB.txt');
dataSearchB = readmatrix('BSTSearchB.txt');
x = linspace(1, 400, 400);

figure(1)
hold on
plot(x, dataInsertA);
plot(x, dataSearchA);
xlabel('Number of Data Points (times 100)')
ylabel('Time (microseconds)');
title('Binary Search Tree: Data Set A');
legend('Insert Function', 'Search Function');
hold off

figure(2)
hold on
plot(x, dataInsertB);
plot(x, dataSearchB);
xlabel('Number of Data Points (times 100)')
ylabel('Time (microseconds)');
title('Binary Search Tree: Data Set B');
legend('Insert Function', 'Search Function');
hold off

%% Linked List
LLdataInsertA = readmatrix('LLinsertA.txt');
LLdataSearchA = readmatrix('LLSearchA.txt');
LLdataInsertB = readmatrix('LLinsertB.txt');
LLdataSearchB = readmatrix('LLSearchB.txt');


figure(3)
hold on
plot(x, LLdataInsertA);
plot(x, LLdataSearchA);
xlabel('Number of Data Points (times 100)')
ylabel('Time (microseconds)');
title('Linked List: Data Set A');
legend('Insert Function', 'Search Function');
hold off

figure(4)
hold on
plot(x, LLdataInsertB);
plot(x, LLdataSearchB);
xlabel('Number of Data Points (times 100)')
ylabel('Time (microseconds)');
title('Linked List: Data Set B');
legend('Insert Function', 'Search Function');
hold off


%% Chaining Hash Table
ChaindataInsertA = readmatrix('hashChaininsertA.txt');
ChaindataSearchA = readmatrix('hashChainsearchA.txt');
ChaindataInsertB = readmatrix('hashChaininsertB.txt');
ChaindataSearchB = readmatrix('hashChainsearchB.txt');
chainCollisionsA = readmatrix('chainColisionsA.txt');
chainCollisionsB = readmatrix('chainColisionsB.txt');

figure(5)
hold on
plot(x, ChaindataInsertA);
plot(x, ChaindataSearchA);
xlabel('Number of Data Points (times 100)')
ylabel('Time (microseconds)');
title('Hash Table, Chaining: Data Set A');
legend('Insert Function', 'Search Function');
hold off

figure(6)
hold on
plot(x, ChaindataInsertB);
plot(x, ChaindataSearchB);
xlabel('Number of Data Points (times 100)')
ylabel('Time (microseconds)');
title('Hash Table, Chaining: Data Set B');
legend('Insert Function', 'Search Function');
hold off

figure(7)
hold on
plot(x, chainCollisionsA);
plot(x, chainCollisionsB);
xlabel('Number of Data Points (times 100)')
ylabel('Number of Colisions');
title('Hash Table, Chaining: Colisions');
legend('Data Set A', 'Data Set B');
hold off

%% Linear Probing Hash Table
LindataInsertA = readmatrix('hashLinearinsertA.txt');
LindataSearchA = readmatrix('hashLinearsearchA.txt');
LindataInsertB = readmatrix('hashLinearinsertB.txt');
LindataSearchB = readmatrix('hashLinearsearchB.txt');
linCollisionsA = readmatrix('LinearCollisionsA.txt');
linCollisionsB = readmatrix('LinearCollisionsB.txt');


figure(8)
hold on
plot(x, LindataInsertA);
plot(x, LindataSearchA);
xlabel('Number of Data Points (times 100)')
ylabel('Time (microseconds)');
title('Hash Table, Linear: Data Set A');
legend('Insert Function', 'Search Function');
hold off

figure(9)
hold on
plot(x, LindataInsertB);
plot(x, LindataSearchB);
xlabel('Number of Data Points (times 100)')
ylabel('Time (microseconds)');
title('Hash Table, Linear: Data Set B');
legend('Insert Function', 'Search Function');
hold off

figure(10)
hold on
plot(x, linCollisionsA);
plot(x, linCollisionsB);
xlabel('Number of Data Points (times 100)')
ylabel('Number of Colisions');
title('Hash Table, Linear: Colisions');
legend('Data Set A', 'Data Set B');
hold off

%% Quartic Probing Hash Table
quartdataInsertA = readmatrix('hashQuarticinsertA.txt');
quartdataSearchA = readmatrix('hashQuarticsearchA.txt');
quartdataInsertB = readmatrix('hashQuarticinsertB.txt');
quartdataSearchB = readmatrix('hashQuarticsearchB.txt');
quartCollisionsA = readmatrix('QuarticCollisionsA.txt');
quartCollisionsB = readmatrix('QuarticCollisionsB.txt');


figure(11)
hold on
plot(x, quartdataInsertA);
plot(x, quartdataSearchA);
xlabel('Number of Data Points (times 100)')
ylabel('Time (microseconds)');
title('Hash Table, Quartic: Data Set A');
legend('Insert Function', 'Search Function');
hold off

figure(12)
hold on
plot(x, quartdataInsertB);
plot(x, quartdataSearchB);
xlabel('Number of Data Points (times 100)')
ylabel('Time (microseconds)');
title('Hash Table, Quartic: Data Set B');
legend('Insert Function', 'Search Function');
hold off

figure(13)
hold on
plot(x, quartCollisionsA);
plot(x, quartCollisionsB);
xlabel('Number of Data Points (times 100)')
ylabel('Number of Colisions');
title('Hash Table, Quartic: Colisions');
legend('Data Set A', 'Data Set B');
hold off

%% Insertion times
figure(14)
hold on 
plot(x, dataInsertA);
%plot(x, dataInsertB);
plot(x, LLdataInsertA);
plot(x, LLdataInsertB);
plot(x, ChaindataInsertA);
plot(x, ChaindataInsertB);
plot(x, LindataInsertA);
plot(x, LindataInsertB);
plot(x, quartdataInsertA);
plot(x, quartdataInsertB);
xlabel('Number of Data Points (times 100)')
ylabel('Time (microseconds)');
title('Insert Functions');
legend('BST A', 'Linked List A', 'Linked List B', 'Hash Chaining A'...
    ,'Hash Chaining B', 'Hash Linear Prob A', 'Hash Linear Prob B',...
    'Hash Quartic Prob A', 'Hash Quartic Prob B');
hold off;

%% Search times
figure(15)
hold on 
plot(x, dataSearchA);
%plot(x, dataSearchB);
plot(x, LLdataSearchA);
plot(x, LLdataSearchB);
plot(x, ChaindataSearchA);
plot(x, ChaindataSearchB);
plot(x, LindataSearchA);
plot(x, LindataSearchB);
plot(x, quartdataSearchA);
plot(x, quartdataSearchB);
xlabel('Number of Data Points (times 100)')
ylabel('Time (microseconds)');
title('Search Functions');
legend('BST A', 'Linked List A', 'Linked List B', 'Hash Chaining A'...
    ,'Hash Chaining B', 'Hash Linear Prob A', 'Hash Linear Prob B',...
    'Hash Quartic Prob A', 'Hash Quartic Prob B');
hold off;
