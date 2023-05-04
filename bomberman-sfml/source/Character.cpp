#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>

enum CharacterState
{
  DownStop,
  DownWalk1,
  DownWalk2,
  UpStop,
  UpWalk1,
  UpWalk2,
  LeftStop,
  LeftWalk1,
  LeftWalk2,
  RightStop,
  RightWalk1,
  RightWalk2,
};

class Character
{
  int x = 45;
  int y = 100;
  int presisionStep = 5;
  int player = 1;
  sf::Texture texture;
  sf::Sprite sprite;
  CharacterState state;
  int timeStep = 0;
  int maxStep = 3;

  void updateTexture()
  {

    switch (state)
    {
    case DownStop:
      texture.loadFromFile("textures/char_1/down_stop.png");
      break;
    case DownWalk1:
      texture.loadFromFile("textures/char_1/down_walk_1.png");
      break;
    case DownWalk2:
      texture.loadFromFile("textures/char_1/down_walk_2.png");
      break;
    case UpStop:
      texture.loadFromFile("textures/char_1/up_stop.png");
      break;
    case UpWalk1:
      texture.loadFromFile("textures/char_1/up_walk_1.png");
      break;
    case UpWalk2:
      texture.loadFromFile("textures/char_1/up_walk_2.png");
      break;
    case LeftStop:
      texture.loadFromFile("textures/char_1/left_stop.png");
      break;
    case LeftWalk1:
      texture.loadFromFile("textures/char_1/left_walk_1.png");
      break;
    case LeftWalk2:
      texture.loadFromFile("textures/char_1/left_walk_2.png");
      break;
    case RightStop:
      texture.loadFromFile("textures/char_1/right_stop.png");
      break;
    case RightWalk1:
      texture.loadFromFile("textures/char_1/right_walk_1.png");
      break;
    case RightWalk2:
      texture.loadFromFile("textures/char_1/right_walk_2.png");
      break;
    default:
      texture.loadFromFile("textures/char_1/down_stop.png");
      break;
    }
    sprite.setTexture(texture);
  }

public:
  Character()
  {
    state = CharacterState::DownStop;
    updateTexture();
  }

  sf::Sprite getCurrentSprite()
  {
    timeStep++;
    sprite.setPosition(x, y);
    return sprite;
  }

  void walkUp()
  {
    if (y > 100)
    {
      y -= presisionStep;
      if (timeStep > maxStep)
      {
        if (state == CharacterState::UpWalk1)
          state = CharacterState::UpWalk2;
        else
          state = CharacterState::UpWalk1;
        timeStep = 0;
      }
    }
    else
      state = CharacterState::UpStop;
    updateTexture();
  }

  void walkDown()
  {
    if (y < 535)
    {
      y += presisionStep;
      if (timeStep > maxStep)
      {
        if (state == CharacterState::DownWalk1)
          state = CharacterState::DownWalk2;
        else
          state = CharacterState::DownWalk1;
        timeStep = 0;
      }
    }
    else
      state = CharacterState::DownStop;
    updateTexture();
  }

  void walkLeft()
  {
    if (x > 45)
    {
      x -= presisionStep;
      if (timeStep > maxStep)
      {
        if (state == CharacterState::LeftWalk1)
          state = CharacterState::LeftWalk2;
        else
          state = CharacterState::LeftWalk1;
        timeStep = 0;
      }
    }
    else
      state = CharacterState::LeftStop;
    updateTexture();
  }

  void walkRight()
  {
    if (x < 725)
    {
      x += presisionStep;
      if (timeStep > maxStep)
      {
        if (state == CharacterState::RightWalk1)
          state = CharacterState::RightWalk2;
        else
          state = CharacterState::RightWalk1;
        timeStep = 0;
      }
    }
    else
      state = CharacterState::RightStop;
    updateTexture();
  }

  void stop()
  {
    if (state == CharacterState::UpWalk1 || state == CharacterState::UpWalk2)
    {
      state = CharacterState::UpStop;
    }
    else if (state == CharacterState::DownWalk1 || state == CharacterState::DownWalk2)
    {
      state = CharacterState::DownStop;
    }
    else if (state == CharacterState::LeftWalk1 || state == CharacterState::LeftWalk2)
    {
      state = CharacterState::LeftStop;
    }
    else if (state == CharacterState::RightWalk1 || state == CharacterState::RightWalk2)
    {
      state = CharacterState::RightStop;
    }
    else
    {
      state = CharacterState::DownStop;
    }
    updateTexture();
  }
};