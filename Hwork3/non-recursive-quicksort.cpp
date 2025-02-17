#include <iostream>
#include <stack>
#include <vector>

using namespace std;

// Partition function 
int partition(vector<int>& arr, int low, int high) {
    int pivot = arr[high];  // Choosing the last element as pivot
    int i = low - 1;  // Index of the smaller element

    for (int j = low; j < high; j++) {
        if (arr[j] <= pivot) {
            i++;
            swap(arr[i], arr[j]);  // Swap elements
        }
    }
    swap(arr[i + 1], arr[high]);  // Move pivot 
    return i + 1;  // Return partition index
}

// Iterative QuickSort 
void quickSortIterative(vector<int>& arr, int low, int high) {
    stack<pair<int, int>> stk;  // Stack to store low and high indices

    // Push initial range
    stk.push({low, high});

    while (!stk.empty()) {
        auto range = stk.top();  // Get top range
        stk.pop();

        int l = range.first, h = range.second;
        if (l < h) {
            int pivotIndex = partition(arr, l, h);

            // Push left subarray if it has more than one element
            if (l < pivotIndex - 1)
                stk.push({l, pivotIndex - 1});

            // Push right subarray if it has more than one element
            if (pivotIndex + 1 < h)
                stk.push({pivotIndex + 1, h});
        }
    }
}


void printArray(const vector<int>& arr) {
    for (int num : arr)
        cout << num << " ";
    cout << endl;
}


int main() {
    int n;
    cout << "Enter the number of elements: ";
    cin >> n;

    vector<int> arr(n);  // Create vector size n
    cout << "Enter " << n << " elements: ";
    for (int i = 0; i < n; i++)
        cin >> arr[i];  // Take user input

    cout << "Original array: ";
    printArray(arr);

    quickSortIterative(arr, 0, n - 1);

    cout << "Sorted array: ";
    printArray(arr);

    return 0;
}
