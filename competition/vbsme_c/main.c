// clangd -O3 -g0 -fno-stack-check -fdelete-null-pointer-checks -fstrict-aliasing -fstrict-overflow -ftree-vectorize -fno-split-stack -finline-functions -fno-builtin  -march=mips32 -fno-stack-protector -fomit-frame-pointer -mno-abicalls -msoft-float
// clang2 -O3 -g0 -march=mips32 -nostdlib -fno-builtin -fno-stack-protector -fomit-frame-pointer -mno-abicalls -fstrict-aliasing -ffast-math -fno-exceptions -ffreestanding
// gcc -O0 -g0 -fno-builtin  -march=mips32r2 -fno-stack-protector -fomit-frame-pointer -mno-abicalls -msoft-float
// -O3 -g0 -mno-abicalls -fno-stack-protector -fomit-frame-pointer -fno-delayed-branch
int main() __attribute__((section(".text.main")));
static inline int abs(int x);
static inline int sad(int frame_y, int frame_x, int window_y, int window_x, int frame[frame_y][frame_x], int window[window_y][window_x], int y, int x);
void vbsme(int frame_y, int frame_x, int window_y, int window_x, int frame[frame_y][frame_x], int window[frame_y][frame_x], int *min_x, int *min_y, int *min_sad) __attribute__((section(".text.vbsme")));
void loop();

int main() {
        int min_x = 0;
        int min_y = 0;
        int min_sad = 16000;

	int asize1[4] = {16, 16, 8, 4};
	int frame1[16][16] = {
		{7, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
		{7, 8, 8, 8, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},
		{7, 8, 8, 8, 2, 8, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30},
		{7, 8, 8, 8, 8, 8, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45},
		{0, 4, 8, 8, 8, 8, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60},
		{0, 5, 8, 8, 8, 8, 30, 35, 40, 45, 50, 55, 60, 65, 70,  75},
		{0, 6, 8, 8, 8, 8, 36, 42, 48, 54, 60, 66, 72, 78, 84, 90},
		{0, 4, 8, 8, 8, 8, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105},
		{0, 1, 8, 8, 8, 8, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120},
		{0, 1, 8, 8, 8, 8, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135},
		{0, 10, 8, 8, 8, 8, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150},
		{0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165},
		{9, 9, 9, 9, 48, 60, 72, 84, 96, 108, 120, 132, 0, 1, 2, 3},
		{9, 9, 9, 9, 52, 65, 78, 91, 104, 114, 130, 143, 1, 2, 3, 4},
		{9, 9, 9, 9, 56, 70, 84, 98, 112, 126, 140, 154, 2, 3, 4, 5},
		{9, 9, 9, 9, 60, 75, 90, 105, 120, 135, 150, 165, 3, 4, 5, 6},
	};
	int window1[8][4] = {
		{8, 8, 8, 8},
		{8, 8, 8, 8},
		{8, 8, 8, 8},
		{8, 8, 8, 8},
		{8, 8, 8, 8},
		{8, 8, 8, 8},
		{8, 8, 8, 8},
		{8, 8, 8, 8},
	};

        // Should be 3, 2
        vbsme(asize1[0], asize1[1], asize1[2], asize1[3], frame1, window1, &min_x, &min_y, &min_sad);
	
	// printf("result: (%d, %d) = %d\n", min_x, min_y, min_sad);

        __asm__ (
                "add $9, $zero, %0\n"   // Move min_x to register $t0
                "add $10, $zero, %1\n"   // Move min_y to register $t1
                "add $11, $zero, %2\n"   // Move min_sad to register $t2
                :  // No outputs
                : "r" (min_x), "r" (min_y), "r" (min_sad)  // Inputs: min_x, min_y, min_sad
        );

        loop();
}

static inline int abs(int x) {
	register int temp = x >> 31;
	x ^= temp;
	x += temp & 1;

	return x;
}

static inline int sad(int frame_y, int frame_x, int window_y, int window_x, int frame[frame_y][frame_x], int window[window_y][window_x], int y, int x) {
	register int sad = 0;
	for (register int i = 0; i < window_y; i++) {
		for (register int j = 0; j < window_x; j++) {
			sad += abs(frame[y + i][x + j] - window[i][j]);
		}
	}
	return sad;
}


void vbsme(int frame_y, int frame_x, int window_y, int window_x, int frame[frame_y][frame_x], int window[frame_y][frame_x], int *min_x, int *min_y, int *min_sad) {
        for (int y = 0; y <= frame_y - window_y; y++) {
                for (int x = 0; x <= frame_x - window_x; x++) {
			int s = sad(frame_y, frame_x, window_y, window_x, frame, window, y, x);
                        if (s < *min_sad) {
                                *min_sad = s;
                                *min_x = x;
                                *min_y = y;
                        }
                }
        }
}

void loop() {
        loop();
}
