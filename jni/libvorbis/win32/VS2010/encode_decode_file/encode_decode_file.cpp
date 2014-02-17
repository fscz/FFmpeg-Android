// encode_decode_file.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
extern "C"
{
#include "encode_file.h"
}


int _tmain(int argc, _TCHAR* argv[])
{
	f1();
	encode_file("d:\\work\\android\\work\\Android\\data\\kaljurand_at_gmail_dot_com.diktofon\\files\\recordings\\1309009273680.wav", "d:\\work\\android\\work\\Android\\data\\kaljurand_at_gmail_dot_com.diktofon\\files\\recordings\\1309009273680.ogg");
	return 0;
}

