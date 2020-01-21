#include <SFML/Graphics.hpp>
#include "render.h"

sf::RenderWindow* window; // window to which we will render
sf::Image* buffer; // image buffer to manipulate pixels
sf::Texture* texture; // sfml can't render image, so we'll create texture from image
sf::Sprite* sprite; // and then sprite from texture, and we'll render the sprite

void InitializeRender(int width, int height) {
	window = new sf::RenderWindow(sf::VideoMode(width, height), "Simple drawer");
	buffer = new sf::Image();
	buffer->create(width, height);
	texture = new sf::Texture();
	texture->loadFromImage(*buffer);
	sprite = new sf::Sprite();
	sprite->setTexture(*texture, true);
}

void SetPixel(int i, int j, char r, char g, char b) {
	buffer->setPixel(i, j, sf::Color(r, g, b));
}

void Flush() {
    sf::Event event;
    while (window->pollEvent(event)) {
        if (event.type == sf::Event::Closed)
            window->close();
    }
	texture->loadFromImage(*buffer);
	window->clear(sf::Color::White);
	window->draw(*sprite);
	window->display();
}

void FreeRender() {
	delete window;
	delete buffer;
	delete texture;
	delete sprite;
}