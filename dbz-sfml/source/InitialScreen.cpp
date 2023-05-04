#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>
#include "./definitions.hpp"

class InitialScreen
{
  sf::Sprite sprite;
  sf::Texture texture;
  sf::Font font;
  sf::Text text;
  sf::Color color;
  sf::Color backgroundColor;
  sf::RectangleShape backgroundShape;
  sf::Music theme;
  sf::Music startPressed;

  bool darken;
  int increment = 20;
  bool gameStarted = false;
  float alphaBackground;

public:
  InitialScreen()
  {
    if (texture.loadFromFile("textures/start_background.jpg"))
      sprite.setTexture(texture);

    startPressed.openFromFile("sounds/burning_fire.ogg");
    if (theme.openFromFile("sounds/theme.ogg"))
      theme.play();

    if (font.loadFromFile("fonts/CracklingFire.ttf"))
      text.setFont(font);

    backgroundShape.setSize(sf::Vector2f(WIDTH_SCREEN, HEIGHT_SCREEN));
    backgroundColor = sf::Color::Black;

    text.setString("Press Start");
    text.setCharacterSize(80);
    text.setPosition(300, 500);

    color = sf::Color::Red;
    color.a = 0;
  };

  int startGame = false;

  void draw(sf::RenderWindow &window)
  {
    color.a = darken ? color.a - increment : color.a + increment;
    if (color.a >= 255 && !darken)
      darken = true;

    if (color.a <= 0 && darken)
      darken = false;

    text.setFillColor(color);

    if (gameStarted && alphaBackground < 250)
      alphaBackground += 15;
    else if (alphaBackground >= 250)
      startGame = true;

    backgroundShape.setFillColor(backgroundColor);
    backgroundColor.a = alphaBackground;
    window.clear();
    window.draw(sprite);
    window.draw(text);
    window.draw(backgroundShape);
    window.display();
  }

  void initGame()
  {
    if (!gameStarted)
    {
      increment *= 3;
      startPressed.setVolume(50);
      startPressed.play();
      theme.stop();
    }
    gameStarted = true;
  }
};