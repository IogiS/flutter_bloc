part of 'goods_bloc.dart';

abstract class GoodsState extends Equatable {
  const GoodsState();
  
  @override
  List<Object> get props => [];
}

class GoodsInitial extends GoodsState {}
