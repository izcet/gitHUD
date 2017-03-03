#include <unistd.h>
#include <string.h>
#include <stdlib.h>

int		main(int argc, char **argv)
{
	int		i;
	int		l;
	int		n;

	if (argc == 3)
	{
		i = 0;
		n = atoi(argv[1]);
		l = strlen(argv[2]);
		while (i++ < n)
			write(1, argv[2], l);
	}
}
