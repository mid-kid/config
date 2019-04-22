#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>

int main(int argc, char **argv)
{
    struct sockaddr_un sock;
    memset(&sock, 0, sizeof(sock));

    sock.sun_family = AF_UNIX;
    strncpy(sock.sun_path, argv[1], sizeof(sock.sun_path));

    int fd = socket(AF_UNIX, SOCK_STREAM, 0);
    if (fd == -1) {
        perror("socket");
        return 1;
    }

    int option = 1;
    if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &option, sizeof(option)) == -1) {
        perror("setsockopt");
        return 1;
    }

    if (bind(fd, (struct sockaddr *)&sock, sizeof(struct sockaddr_un)) == -1) {
        perror("bind");
        return 1;
    }

    close(fd);
    return 0;
}
