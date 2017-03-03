#include <string.h>
#include <stdlib.h>
#include <unistd.h>

int		main(int argc, char **argv)
{
	long	l;

	if (argc == 2)
	{
		l = strlen(argv[1]);
		while (l > 0)
		{
			while (l > 0 && argv[1][l - 1] == '/')
				l -= 1;
			if (l > 0)
				write(1, argv[1], l);
			while (l > 0 && argv[1][l - 1] != '/')
				l -= 1;
			if (l > 0)
				write(1, " ", 1);
		}
		write(1, "\n", 1);
	}
}
