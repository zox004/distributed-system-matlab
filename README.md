# Distributed System using Matlab

# I. Introduction

X-Ray에 Disease Recognition 대한 고성능 질병 분류를 위해서 Deep Learning 기반의 복잡하지만 확실한 성능을 가진 고급 기술이 필요한데, 이러한 Deep Learning 기술은 Computation Power가 많이 필요하다. 이를 MATLAB에서 제공되는 Parallel Pool을 이용하여 5대의 Server Machine에 Distributed System Environment를 구성해 더욱 높은 Computation Power를 사용하여 Training Speed를 높히고 최적의 Neural Network를 찾아 적절한 Layer의 Modification을 진행하는데 있어서 빠른 처리를 할 수 있도록 이 프로젝트를 기획했다.

# II. Deployment Diagram

![image](https://user-images.githubusercontent.com/56228085/171381548-24544a87-4dad-45c9-a3bd-8456fb0dd748.png)
![image](https://user-images.githubusercontent.com/56228085/171381603-6976ee64-94e3-4e90-8b46-254cfbc34862.png)


### SoftWare

MATLAB Parallel pool environment  
[https://www.mathworks.com/products/parallel-computing.html](https://www.mathworks.com/products/parallel-computing.html)

# III. SW Requirement

## Functional Requirement

| Ref.#  | Function  | Category  |
| --- | --- | --- |
| R1.1  | Train Neural Network  | Evident  |
| R1.2  | Validate Training  | Evident  |
| R1.3  | Plot Training Results  | Evident  |
| R2.1  | Get Job  | Hidden  |
| R2.2  | Schedule Job  | Hidden  |
| R2.3  | Send to worker node  | Hidden  |
| R2.4  | Run Task  | Hidden  |
| R2.5  | Return Task Result  | Hidden  |
| R2.6  | Assemble Tasks Results  | Hidden  |
| R2.7  | Return Job Result  | Hidden  |

## Use Case Diagram

![image](https://user-images.githubusercontent.com/56228085/171381691-0976c5fe-5fc9-43b8-b996-b6919fd2e473.png)

## Non-Functional Requirement

- 성능

MATLAB에서 제공하는 Parallel Pool 기능은 최대 512개의 workers 사용할 수 있기 때문에 보유하고 있는 Machine의 수가 많을 수록 엄청난 Computation Power를 지니게 되어 Training Speed를 대폭 높일 수 있다.

- 구현상제약사항

MATLAB의 Parallel Pool 기능을 사용하기 위해서는 유료 구매 혹은 Campus License가 필요하다.

# IV. Our Method

## Aggreagated Residual Transformation

$F(x) = \sum_{i=1}^{C} T_{i}(x)$

![image](https://user-images.githubusercontent.com/56228085/176624288-79920401-916b-41d9-862a-a16a4ebc2776.png)

**Aggregated Residual Transformation Method**

위에 보이는 Neural Network는 ResNeXt의 최하단 Layer로 위 수식의 Ti를 변형 하는 과정을 보여주는 것이다. 기존의 ResNeXt에서는 인풋을 여러 갈래로 분할하여 다시 concatenation을 진행한다. 이를 수학적 동치를 이루지만 더욱 간단한 Feature로 변형한 방법을 활용하여 Neural Network을 더욱 가볍게 만드는 기술이다. 이를 활용하여 기존의 좋은 성능을 보여주는 Deep Neural Network에 Computation에 무리가 가지 않을정도로 변형을 주어 한층 더 upgrade 된 Neural Network로 Modify 해보고자 한다.

# V. Risk Analysis and Reduction Plan

- Fire wall Problem (Solved)
Fire wall 등의 보안상의 이슈로 Parallel Pool Server의 각 Node의 통신에 장애가 생기는 문제.

    → 모든 Node 들의 Firewall을 disable 하고 각 Node의 /etc/exports와 /etc/hosts에 서로의 정보를 넣어줌으로써 해결

- Data Input Channel Problem (Solved)
현 Project를 진행하는데 있어서 MATLAB에서 제공하는 Neural Network들이 모두 RGB data에 맞춰져 있지만 본 팀이 사용하는 dataset이 X-Ray Data임으로 input channel 수가 맞지 않아 Training을 원활히 할 수 없는 문제

    → MATLAB code를 직접 작성하여 Colour Preprocessing을 진행해 Input Channel의 수를 맞춰주어 해결

- Layer Modification Problem
Neural Network를 적절히 Modify 하는데 있어서 Network Design의 개념 등의 부족으로 논리적 오류 없이 설계하기가 힘든 문제

    → Reference Paper들을 깊이있게 공부해 수학적 논리적 오류가 최대한 없도록 설계할 것이며 MATLAB에서 제공하는 기능중 하나인 검사 프로그램을 활용하여 해결할 계획

- Training Accuracy Problem
예상한 만큼의 Training Accuracy를 비롯한 Neural Network의 성능이 좋게 나오지 못함

    → 이는 각 Neural Network 마다 여러번의 Training을 진행하여 우연성으로 나오는 결과를 최대한 배제하여 해결할 예정

# VI. Reference

- MATLAB Parallel pool environment

**[https://www.mathworks.com/help/parallel-computing/run-code-on-parallel-pools.html](https://www.mathworks.com/help/parallel-computing/run-code-on-parallel-pools.html)**\n
**[https://www.mathworks.com/products/parallel-computing.html](https://www.mathworks.com/products/parallel-computing.html)**

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

# VII. Programming

## Dataset

[Chest-Xray8 (COVID-19) Dataset | Papers With Code](https://paperswithcode.com/dataset/chest-xray8-covid-19)

Class : 코로나, 폐렴, 정상

## Models

- VGG-19 (two-stage)
- darknet-53 (one-stage)
- squeezenet (two-stage)
- EfficientNet (two-stage)
- ResNet-101 (two-stage)

## Activation Function

- ADAM
- SGDM
- Rmsprop

## Training Option

- Learning Rate : 0.0001
- validation frequency : 50
- max epoch : 25
- Execution Environment : parallel

## Help

- MATLAB 창이 닫힌 경우 다음과 같은 코드로 다시 런처를 킬 수 있다.

```matlab
/usr/local/MATLAB/R2022a/bin/matlab
```

### Designer

- Fully Connected layer에서 output의 수를 사용할 dataset의 class의 수로 change
- Pre-trained model은 바뀌지 않으므로 FC layer부터 그 하단의 layer를 직접 새로 설정
- Analyze를 통해 Error check

### Data

- When importing dataset, random rotation [min:-1, max:1], random rescailing [min:1, max:2]
- Test data 20% (randomize)

### Training

- Learning rage : 0.0001
- Validation frequency : 50
- Max epoch : 25
- Mini Batch size : 35
- Execution Environment : parallel

### Requirement

- MATLAB 실행 후 colour preprocess 코드를 통해 RGB input을 gray input으로 변환해 input channel error를 해결해준다.(input은 Neural Network중 input layer의 input size, [ex) 224 224 3])
- imort Datastore의 정상 화면

![image](https://user-images.githubusercontent.com/56228085/171382074-3da726e3-3353-46bd-b49f-8e3b4fa743ab.png)

### 비교 분석 방법

- ROC curves
- Confusion
