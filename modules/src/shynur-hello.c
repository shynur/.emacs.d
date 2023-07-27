#include <stdio.h>

#include <emacs-module.h>
int plugin_is_GPL_compatible;


// Module 应当 export 该函数.
// 该函数 return 0 代表 初始化 成功.
//
// 参数‘runtime’有两个 public field:
//   1. size - ‘runtime’的大小 (bytes).
//   2. get_environment - 函数指针.
int emacs_module_init(struct emacs_runtime *runtime) {
    // 这些类型的大小只增不减.
    if (runtime->size < sizeof(*runtime))
        return 1;
    emacs_env *env = runtime->get_environment(runtime);
    if (env->size < sizeof(*env))
        return 2;

    // ...
    puts("Hello!");

    return 0;
}

/* emacs_value shynur_hello(emacs_env *env, ptrdiff_t nargs, */
/*                          emacs_value *args, */
/*                          void *data) { */

/* } */

/*
 * 编译:
 *   gcc -I /usr/local/include/ -fPIC -shared shynur-example.c -o shynur-example.so
 *                                                      MS-Windows 上应该是‘*.dll’.
 */

/* Local Variables:    */
/* coding: utf-8-unix  */
/* End:                */
