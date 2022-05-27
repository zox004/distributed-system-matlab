# Distributed System using Matlab

# 0. Introduction

X-Ray 의료데이터를 통해 질병을 Classification 하는데 있어서 최적의 Neural Network 를 찾는 연구과정을 진행할 계획이다. 위의 연구를 진행하는데 있어서 Training data와 Test data의 분류, 기존의 대표적인 Neural Networks들과 최신 Neural Networks 그리고 해당 팀에서 진행할 Modified Neural Networks의 성능 비교분석을 위해서는 아주 많은 Training time이 필요하다. 이러한 문제점을 Distributed Computing System을 활용하여 Training 속도를 올리고 더욱 많은 데이터를 활용하여 Training Accuracy 향상을 하고자 함.

# 1. 최종산출물의 형태 및 기능

- HW Platform

MATLAB에서 제공하는 Parallel Pool 기능으로 Distributed Computing Systems를 활용한 Deep Learning의 Training Environment.

![image](https://user-images.githubusercontent.com/56228085/170646911-aa60d443-974f-4931-858c-fb07796e9eb3.png)

- SW Platform

X-Ray 이미지를 통한 환자의 질병 인식에 있어서 최적(가장 높은 Accuracy)를 보이는 Neural Network.

Dataset의 특징에 맞는 Training method 탐색 및 Neural Network의 Modification으로 독창적인 알고리즘과 Neural Netwok를 만들 계획.

- 활용한 SW

MATLAB Parallel pool environment

[https://www.mathworks.com/help/parallel-computing/run-code-on-parallel-pools.html](https://www.mathworks.com/help/parallel-computing/run-code-on-parallel-pools.html)

[https://www.mathworks.com/products/parallel-computing.html](https://www.mathworks.com/products/parallel-computing.html)

- 직접 개발할 내용

X-Ray 이미지를 통한 환자의 질병 인식에 있어서 최적(가장 높은 Accuracy)를 보이는 Neural Network.

정확하게 환자의 질병을 인식하고 분류해야 하기 때문에 regional proposal과 classification이 순차적으로 이루어지는 two-stage detector를 사용할 것임.

![image](https://user-images.githubusercontent.com/56228085/170646773-5c21a847-2268-4b0f-bb42-5448deb1b75e.png)

# 2. Risk Analysis

- Configuration Problem
    - MATLAB 에서 제공하는 Parallel Pool의 Machine의 성능에 알맞는 Worker 수와 적절한 Computation을 이끌어낼 수 있는 여러 Configuration 관련 문제
- Version Match Problem
    - MATLAB과 프로그램이 설치될 Machine의 Ubuntu version 매칭 문제.
- Proxy Problem
    - 분산처리를 함에 있어서 통신 중 방화벽 및 proxy등의 이유로 발생하는 통신문제.
- Training
    - Training을 진행함에 있어서 Machine Learning의 특성상 항상 좋은 결과가 나올것이라고 보장할 수 없음.
- Risk Management
    - MATLAB 자체에서 Distribute Computing System 기능을 제공하긴 하지만 Risk Management에 있어서는 충분하지 않아 Fault가 생길 시 일부 문제에 있어서는 직접 수동으로 해결해야함.

# 3. Risk Reduction Plan

- Configuration Problem
    - Worker node를 구성하는 Machine에 있어서 가급적 성능이 비슷한 Machine들로 구성하여 하나의 Configuration을 찾으면 나머지에 apply 할 수 있도록 함.
- Version Match Problem
    - MATLAB Parallel Pool Kit 설치 전 호환성 확인.
- Proxy Problem
    - 필요한 Port에 한정하여 firewall을 끄는 방식으로 진행하겠지만 지속적인 오류 발생시 전체 firewall을 disable 하고 진행
- Training
    - 하나의 Neural Network에 대해 3번정도 Training을 진행하여 결과를 비교함.
- Risk Management
    - MATLAB 자체의 Source code를 modify할 수 없음으로 Telegram API등을 활용하여 Fault 여부를 모니터링함.

# 4. Success Criteria

단일 worker node와 Distributed System 을 활용한 training 환경이 확연한 차이를 보임.

X-Ray image classification에 있어서 98% 이상의 Accuracy를 보이는 최적의 Neural Network을 찾음.

# 5. 참고 문헌

- MATLAB Parallel pool environment

[https://www.mathworks.com/help/parallel-computing/run-code-on-parallel-pools.html](https://www.mathworks.com/help/parallel-computing/run-code-on-parallel-pools.html)
****[https://www.mathworks.com/products/parallel-computing.html](https://www.mathworks.com/products/parallel-computing.html)

- **Deep Learning Algorithms Correctly Classify *Brassica rapa* Varieties Using Digital Images**

[readcube.com](http://readcube.com/)

- Detection of rice plant diseases based on deep transfer learning

**[https://www.researchgate.net/publication/339653204_Detection_of_rice_plant_diseases_based_on_deep_transfer_learning](https://www.researchgate.net/publication/339653204_Detection_of_rice_plant_diseases_based_on_deep_transfer_learning)**

- Quo Vadis, Action Recognition? A New Model and the Kinetics Dataset

**[https://arxiv.org/pdf/1705.07750.pdf](https://arxiv.org/pdf/1705.07750.pdf)**

- Learning Transferable Architectures for Scalable Image Recognition

**[https://arxiv.org/pdf/1707.07012.pdf](https://arxiv.org/pdf/1707.07012.pdf)**

- Squeeze-and-Excitation Networks

**[https://arxiv.org/pdf/1709.01507.pdf](https://arxiv.org/pdf/1709.01507.pdf)**

# Programming

## Models

- VGG-19
- darknet-53
- squeezenet
- EfficientNet
- ResNet-101

## Activation Function

- ADAM
- SGDM
- Rmsprop

Learning Rate = 0.0001

## Help

- MATLAB 창이 닫힌 경우 다음과 같은 코드로 다시 런처를 킬 수 있다.
```bash
/usr/local/MATLAB/R2022a/bin/matlab
```
