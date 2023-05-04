#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>
#include <sstream>
#include <string>

enum CharacterState
{
  Transforming,
  Stoped,
  Moving,
  Punching
};

class Character
{
  bool Transforming = false;

  int x = 850;
  int y = 430;
  int presisionStep = 5;
  int timeStep = 0;
  int maxStep = 3;
  int stepsMovement = 0;
  int step = 1;

  CharacterState state;

  sf::Texture texture;
  sf::Sprite sprite;
  sf::Music hitSound;

  std::string name;

public:
  Character()
  {
    std::stringstream ss;
    ss << "textures/goku/presentation/" << step << ".png";
    texture.loadFromFile(ss.str());
    sprite.setTexture(texture);
    sprite.setPosition(x, y);
  }

  sf::Sprite getCurrentSprite()
  {
    if (timeStep > 3)
    {
      updateSprite();
      sprite.setPosition(x, y);
      timeStep = 0;
    }
    timeStep++;
    return sprite;
  }

  void presentation()
  {
    if (!Transforming)
    {
      state = CharacterState::Transforming;
      Transforming = true;
    }
  }

  void forcePresentation()
  {
    state = CharacterState::Transforming;
    step = 1;
  }

  void punch()
  {
    if (state == CharacterState::Stoped)
    {
      state = CharacterState::Punching;
      step = 1;
      hitSound.stop();
      hitSound.openFromFile("sounds/punch.ogg");
      hitSound.play();
    }
  }

  void updateSprite()
  {
    sf::Sprite spriteUpdated;
    std::stringstream ss;
    switch (state)
    {
    case CharacterState::Transforming:
      if (step > 10)
      {
        state = CharacterState::Stoped;
        step = 1;
      }
      else
      {
        ss << "textures/goku/presentation/" << step << ".png";
        texture.loadFromFile(ss.str());
        sprite = spriteUpdated;
        sprite.setTexture(texture);
        step++;

        if (step == 7)
        {
          hitSound.stop();
          hitSound.openFromFile("sounds/powerup.ogg");
          hitSound.play();
        }
      }
      break;
    case CharacterState::Stoped:
      if (step > 10)
        step = 1;
      ss << "textures/goku/stoped/" << step << ".png";
      texture.loadFromFile(ss.str());

      sprite = spriteUpdated;
      sprite.setTexture(texture);
      step++;
      break;
    case CharacterState::Moving:
      break;
    case CharacterState::Punching:
      if (step > 4)
      {
        state = CharacterState::Stoped;
        step = 1;
      }
      else
      {
        ss << "textures/goku/punch/" << step << ".png";
        texture.loadFromFile(ss.str());

        sprite = spriteUpdated;
        sprite.setTexture(texture);
        step++;
      }
      break;
    }
  }
};