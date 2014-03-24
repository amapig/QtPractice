#include <stdio.h>
#include <glib.h>

int main() {
    GArray *garray;
    gint i;
    /* We create a new array to store gint values.
       We don't want it zero-terminated or cleared to 0's. */
    garray = g_array_new (FALSE, FALSE, sizeof (gint));
    for (i = 0; i < 100; i++) {
        g_print ("i = %d\n", i);
        g_array_append_val (garray, i);
    }

    for (i = 0; i < 100; i++) {
        if (g_array_index (garray, gint, i) != i)
            g_print ("ERROR: got %d instead of %d\n",
                     g_array_index (garray, gint, i), i);
    }

    g_array_free (garray, TRUE);

    return 1;
}
