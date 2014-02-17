#include <string.h>
#include <jni.h>

/* This is a trivial JNI example where we use a native method
 * to return a new VM String. See the corresponding Java source
 * file located at:
 *
 *   apps/samples/hello-jni/project/src/com/example/HelloJni/HelloJni.java
 */
void
Java_com_alehro_audio_jni_WavOggFileCoder_encodefile( JNIEnv* env,
                                                  jobject thiz, jstring fin_path, jstring fout_path)
{
//Get the native string from javaString
     const char *native_fin_path = (*env)->GetStringUTFChars(env, fin_path, 0);
	 const char *native_fout_path = (*env)->GetStringUTFChars(env, fout_path, 0);
 
 //TODO: errror handling
	 encode_file(native_fin_path, native_fout_path);
     //Do something with the nativeString
 
     //DON'T FORGET THIS LINE!!!
     (*env)->ReleaseStringUTFChars(env, fin_path, native_fin_path);
	 (*env)->ReleaseStringUTFChars(env, fout_path, native_fout_path);	 

    //return (*env)->NewStringUTF(env, "Hello from JNI !");
} 