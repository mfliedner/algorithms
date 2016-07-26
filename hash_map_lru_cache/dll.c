#include <stdio.h> // for size_t and error message

struct link {
    int value;
    link *prev;
    link *next;
};
typedef struct link Link;

Link *DoublyLinkedList(const int array[], size_t length)
{
	/* sentinel nodes head and tail will be used in order to avoid
	    dealing with empty lists, the first and last element of the
		array could serve the same function */
	Link *head = (Link *)malloc(sizeof(Link));
	head->prev = NULL;
     Link *tail = (Link *)malloc(sizeof(Link));
	tail->next = NULL;
     tail->prev = head; /* for the truly paranoid */
     head->next = tail;

	/* pointer to the current link while building the list */
	Link *current = head;

	size_t i;
	for(i = 0; i < length; i++) {
		Link new_link = (Link *)malloc(sizeof(Link));
		if (new_link == NULL) {
			printf(“memory allocation error!”);
		}
		new_link->value = array[i];
		new_link->prev = current;
		new_link->next = NULL;
		current->next = new_link;
		current = new_link;
	}
	tail->prev = current;
	return head->next; // points to first array link
}
