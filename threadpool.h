#ifndef THREADPOOL_H
#define THREADPOOL_H

#include <vector>
#include <string>
#include <functional>
#include <queue>
#include <thread>
#include <mutex>
#include <condition_variable>

class Threadpool {
public:
    Threadpool(int threadNum, bool start = true)
        : m_threadNum(threadNum > 0 ? threadNum : std::thread::hardware_concurrency()), m_isRun(start) {
        works.resize(m_threadNum); // 开始时构建? 带:的ctor能写在类外吗
    }
    ~Threadpool();
    int run(); // start pool
    template<typename T>
    void enqueue(T task);

private:
    bool m_isRun;
    int m_threadNum;
    std::vector<std::thread> works;
    std::queue<std::function<void(void)>> taskQue;
    std::mutex queMutex;
    std::condition_variable cond;

private: // 几个部分写的顺序是什么? 加不加private这些?
    std::function<void(void)> deque();
};

#endif
