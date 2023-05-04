#include <SFML/Graphics.hpp>
#include "./definitions.hpp"

using sf::Color;

class ArenaScreen
{
  sf::Sprite sprite;
  sf::Texture texture;
  sf::RectangleShape backgroundShape;
  Color backgroundColor;

  bool screenLoaded = false;
  float alphaBackground = 255;

public:
  ArenaScreen()
  {
    if (texture.loadFromFile("textures/arena.jpg"))
      sprite.setTexture(texture);

    backgroundColor = Color::Black;
    backgroundColor.a = alphaBackground;
    backgroundShape.setSize(sf::Vector2f(WIDTH_SCREEN, HEIGHT_SCREEN));
  }

  void draw(sf::RenderWindow &window, sf::Sprite spriteChar)
  {
    if (!screenLoaded && alphaBackground > 0)
      alphaBackground -= 5;
    else if (alphaBackground <= 0)
      screenLoaded = true;

    backgroundColor.a = alphaBackground;
    backgroundShape.setFillColor(backgroundColor);

    window.clear();
    window.draw(sprite);
    window.draw(spriteChar);
    window.draw(backgroundShape);

    window.display();
  }
};
