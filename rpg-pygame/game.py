import pygame
import os

pygame.init()
screen = pygame.display.set_mode((400, 300))
done = False
x, y = 0, 0

clock = pygame.time.Clock()

_image_library = {}


def get_image(path):
    global _image_library
    image = _image_library.get(path)
    if image == None:
        canonicalized_path = path.replace('/', os.sep).replace('\\', os.sep)
        image = pygame.image.load(canonicalized_path)
        _image_library[path] = image
    return image


step = 1

while not done:
    for event in pygame.event.get():
        if(event.type == pygame.QUIT):
            done = True

    pressed = pygame.key.get_pressed()

    if(pressed[pygame.K_LEFT] and x > 0):
        x -= 1
    if(pressed[pygame.K_RIGHT] and x < 200):
        x += 1
    if(pressed[pygame.K_UP] and y > 0):
        y -= 1
    if(pressed[pygame.K_DOWN] and y < 200):
        y += 1
        step += .3

    if int(step) > 9:
        step = 1

    pygame.display.flip()
    screen.fill((0, 0, 0))
    screen.blit(get_image('walk_down/' + str(int(step)) + '.png'), (x, y))
    clock.tick(30)
