#include "render.h"

int main() {
	const int W = 128;
	const int H = 128;
	InitializeRender(W, H);
	for (int i = 0; i < W; i++) {
		for (int j = 0; j < H; j++) {
			SetPixel(i, j, i, j, (i+j));
		}
	}
	Flush();
	while(1) {

	}
	FreeRender();
	return 0;
}