
// creates window WxH
void InitializeRender(int width, int height);
// sets pixel in buffer
void SetPixel(int i, int j, char r, char g, char b);
// flushes buffer to the screen
void Flush();
// frees memory, so you can initialize render again
void FreeRender();