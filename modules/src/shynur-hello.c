#include <time.h>
#include <stdio.h>
#include <string.h>

#include <emacs-module.h>
// 必须 export 如下两个符号:
int plugin_is_GPL_compatible; // Declaring such a symbol does NOT mean that
                              // this file is under the GPL or compatible license.
int emacs_module_init(struct emacs_runtime *);

char *shynur_hello_get_current_time_string() {
    time_t current_time;
    time(&current_time);

    static char time_string[100]; // 够大就行.
    strftime(time_string, sizeof(time_string),
             "%H:%M:%S %m/%d %Y", localtime(&current_time));

    return time_string;
}

/* 作为一个 module function, 该函数必须吻合‘emacs_function’类型.
 * 通常在函数‘emacs_module_init’中使用‘env->make_function’将其
 * 制成 Lisp function object.                                     */
emacs_value Fshynur_hello(emacs_env *env,
                          ptrdiff_t nargs, emacs_value *args,
                          // ‘data’的作用相当于 Lisp 函数‘apply-partially’, 有点像柯里化;
                          // 它还会被传递给 function finalizer.
                          void *data) {
    char printed_arg1[10]; // 够大就行.
    size_t arg1_printed_len = sizeof(printed_arg1);
    env->copy_string_contents(env,
                              env->funcall(env,
                                           env->intern(env, "format"), 2,
                                           (emacs_value[]){
                                               env->make_string(env, "%s", 2),
                                               args[0]}),
                              printed_arg1, &arg1_printed_len);

    char message[1000]; // 够大就行.
    sprintf(message,
            "Hello, %s!\n"
            "I was made at: %s",
            printed_arg1, data);

    emacs_value return_value = env->make_unibyte_string(env, message, strlen(message));
    env->funcall(env,
                 env->intern(env, "message"), 2,
                 (emacs_value[]){env->make_string(env, "%s", 2), return_value});
    return return_value;
}

/* 该函数必须吻合‘emacs_finalizer’类型.
 * Finalizer 不应该 (也无法) 和 Emacs 有任何交互.  */
void Fshynur_hello_Finalizer(void *data) {}

/* 该函数 return 0 代表 初始化 成功.
 *
 * 参数‘runtime’有两个 public field:
 *   1. size - ‘runtime’的大小 (bytes).
 *   2. get_environment - 函数指针.      */
int emacs_module_init(struct emacs_runtime *runtime) {
    if (runtime->size < sizeof(*runtime))               // 类型‘emacs_runtime’和‘emacs_env’
        return 1;                                       // 的字节数只会随着版本增长, 因此可
                                                        // 以据此验证兼容性, 或是针对不同的
    emacs_env *env = runtime->get_environment(runtime); // 版本区间进行不同的操作.  (See
                                                        // also ‘EMACS_MAJOR_VERSION’ in
    if (env->size < sizeof(*env))                       // the included <emacs_module.h>.)
        return 2;                                       // 我们用‘env’模拟 OOP.

    /* 通常验证完兼容性之后, 就是制作 Lisp function object.  */
    emacs_value shynur_hello = env->make_function(env,
                                                  1, emacs_variadic_function,
                                                  Fshynur_hello,
                                                  // NULL pointer,
                                                  // ASCII string,
                                                  // or UTF-8 encoded non-ASCII string:
                                                  "打印并返回一个字符串.\n"
                                                  "“Hello, ARG!\n"
                                                  " 我制造于: TIME”\n"
                                                  "ARG 的打印表示 不能含有 NULL 字符 (可能连 non-ASCII 也不行)!",
                                                  shynur_hello_get_current_time_string());
    env->make_interactive(env, shynur_hello, env->make_string(env, "P", 1)),
        env->set_function_finalizer(env, shynur_hello, Fshynur_hello_Finalizer);

    env->funcall(env,
                 env->intern(env, "defalias"), 2,
                 (emacs_value[]){env->intern(env, "shynur/hello"), shynur_hello});

    /* 按照惯例, provide 一下.  */
    env->funcall(env,
                 env->intern(env, "provide"), 1,
                 (emacs_value[]){env->intern(env, "shynur-hello")});

    return 0;
}

/*
编译:
  gcc -I /usr/local/include/ -fPIC -shared ./shynur-hello.c -o ../shynur-hello.so
动态链接库的实际后缀 见 ‘module-file-suffix’.
*/

/* Local Variables:    */
/* coding: utf-8-unix  */
/* End:                */
