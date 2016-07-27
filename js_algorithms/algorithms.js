// Mergesort
function merge(left, right) {
  const merged = [];

  while (left.length > 0 && right.length > 0) {
    let nextItem = (left[0] < right[0]) ? left.shift() : right.shift();
    merged.push(nextItem);
  }

  return merged.concat(left, right);
}

function mergeSort(array) {
  if (array.length < 2) {
    return array;
  } else {
    const middle = Math.floor(array.length / 2);

    const left = mergeSort(array.slice(0, middle));
    const right = mergeSort(array.slice(middle));

    return merge(left, right);
  }
}

// Bubblesort
Array.prototype.bubbleSort = function() {
  let sorted = false;

  while (!sorted) {
    sorted = true;
    for(let i = 0; i < this.length-1; i++) {
      if (this[i]>this[i+1]) {
        let temp = this[i];
        this[i] = this[i+1];
        this[i+1] = temp;
        sorted = false;
      }
    }
  }

  return this;
};

// Quicksort
Array.prototype.quickSort = function (comparator) {
  if (typeof comparator !== "function") {
    comparator = function (x, y) {
      if (x === y) {
        return 0;
      } else if (x < y) {
        return -1;
      } else {
        return 1;
      }
    };
  }

  if (this.length < 2) {
    return this;
  }

  const pivot = this[0];
  const left = [];
  const right = [];

  for (let i = 1; i < this.length; i++) {
    if (comparator == undefined) {
      if (this[i] < pivot) {
        left.push(this[i]);
      } else {
        right.push(this[i]);
      }
    } else {
      if (comparator(this[i], pivot) < 0) {
        left.push(this[i]);
      } else {
        right.push(this[i]);
      }
    }
  }

  const lsort = left.quickSort(comparator);
  lsort.push(pivot);
  const rsort = right.quickSort(comparator);
  const sorted = lsort.concat(rsort);
  return sorted;
};

// Binary search
function binarySearch(array, target) {
  if (array.length === 1) {
    return (array[0] === target) ? 0 : undefined;
  }
  let midpoint = Math.round(array.length/2);
  let left_side = array.slice(0, midpoint);
  let right_side = array.slice(midpoint);

  return (array[midpoint] > target) ? binarySearch(left_side, target) : (binarySearch(right_side, target) + midpoint);
}
