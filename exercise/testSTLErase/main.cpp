#include <iostream>
#include <list>
using namespace std;

int main()
{
    std::list test_list;
    std::list::iterator test_list_it;

    test_list.push_back(1);

    test_list_it = test_list.begin();
    for(;test_list_it != test_list.end();test_list_it++)

    {
        test_list.erase(test_list_it);
    }
}
