import java.util.*;
import java.util.Scanner;
import java.io.*;
import java.lang.*;
import java.util.Collections;

public class Reversi{
	
	public static int[][] a=new int[8][8];
	public static Stack<Integer> change_x;
	
	public static Stack<Integer> change_y;
	
	static void printBoard(){
		String start=new String();
		for(int i=0;i<9;i++){
				start=start+i+"";
		}
		start=start+0;
		System.out.println(start);
		for(int i=0;i<8;i++){
			String s=new String();
				s=(i+1)+" ";
			for (int j=0;j<8;j++){
				
				switch (a[j][i]){
					case 1: s=s+"X";
					break;
					case 0: s=s+"O";
							break;
					case 3: s=s+"?";
							break;
					default: s=s+"_";
				}
				
			}
			s=s+(i+1);
			System.out.println(s);
		}
		String start1=new String();
		for(int i=0;i<9;i++){
				start1=start1+i+"";
		}
		start1=start1+0;
		System.out.println(start1);
		
	}
	
	static boolean isValid(int x,int y,int z){
			if(a[x-1][y-1]==1||a[x-1][y-1]==0){
				return false;
			}
		
			int counter=(z+1)%2;
			int x_temp,y_temp;
			int maybe;
			boolean valid=false,validPart;
			
			change_x=new Stack<Integer>();
			change_y=new Stack<Integer>();
			
			//above
			y_temp=y;
			x_temp=x;
			maybe=0;
			y_temp=y_temp-1;
			int k=0,temp;
			validPart=false;
			while(y_temp!=0){
				if(a[x_temp-1][y_temp-1]!=0&&a[x_temp-1][y_temp-1]!=1){
				break;
				}
				if(a[x_temp-1][y_temp-1]==counter){
					maybe=1;
					change_x.push(x_temp);
					change_y.push(y_temp);
					k++;
				}
				if(a[x_temp-1][y_temp-1]==z){
					if(maybe==1){
					valid=true;
					validPart=true;
					//System.out.println("Valid in above");
					}
					break;
				}
				y_temp=y_temp-1;
			}
			if(validPart==false){
					while(k!=0){
						temp = (int) change_x.pop();
						temp = (int) change_y.pop();
						k--;
					}
				}
			//below
			y_temp=y;
			x_temp=x;
			maybe=0;
			y_temp=y_temp+1;
			k=0;
			validPart=false;
			while(y_temp!=9){
				if(a[x_temp-1][y_temp-1]!=0&&a[x_temp-1][y_temp-1]!=1){
				break;
				}
				if(a[x_temp-1][y_temp-1]==counter){
					maybe=1;
					change_x.push(x_temp);
					change_y.push(y_temp);
					k++;
				}
				if(a[x_temp-1][y_temp-1]==z){
					if(maybe==1){
					valid=true;
					validPart=true;
					//System.out.println("Valid in below");
					}
					break;
				}
				y_temp=y_temp+1;
			}
			if(validPart==false){
					while(k!=0){
						temp = (int) change_x.pop();
						temp = (int) change_y.pop();
						k--;
					}
				}
			//Left
			y_temp=y;
			x_temp=x;
			maybe=0;
			x_temp=x_temp-1;
			k=0;
			validPart=false;
			while(x_temp!=0){
				if(a[x_temp-1][y_temp-1]!=0&&a[x_temp-1][y_temp-1]!=1){
				break;
				}
				if(a[x_temp-1][y_temp-1]==counter){
					maybe=1;
					change_x.push(x_temp);
					change_y.push(y_temp);
					k++;
					//System.out.println("Left value of k:"+k);
				}
				if(a[x_temp-1][y_temp-1]==z){
					if(maybe==1){
					valid=true;
					validPart=true;
					//System.out.println("Valid in left");
					}
					break;
				}
				x_temp=x_temp-1;
			}
			
				if(validPart==false){
					while(k!=0){
						temp = (int) change_x.pop();
						temp = (int) change_y.pop();
						k--;
					}
				}
			//Right
			y_temp=y;
			x_temp=x;
			maybe=0;
			x_temp=x_temp+1;
			k=0;
			validPart=false;
			while(x_temp!=9){
				if(a[x_temp-1][y_temp-1]!=0&&a[x_temp-1][y_temp-1]!=1){
				break;
				}
				if(a[x_temp-1][y_temp-1]==counter){
					maybe=1;
					change_x.push(x_temp);
					change_y.push(y_temp);
					k++;
				}
				if(a[x_temp-1][y_temp-1]==z){
					if(maybe==1){
					valid=true;
					validPart=true;
					//System.out.println("Valid in right");
					}
					break;
				}
				x_temp=x_temp+1;
			}
			if(validPart==false){
					while(k!=0){
						temp = (int) change_x.pop();
						temp = (int) change_y.pop();
						k--;
					}
				}
			//right up diagonal
			y_temp=y;
			x_temp=x;
			maybe=0;
			x_temp=x_temp+1;
			y_temp=y_temp-1;
			k=0;
			validPart=false;
			while(x_temp!=9&&y_temp!=0){
				if(a[x_temp-1][y_temp-1]!=0&&a[x_temp-1][y_temp-1]!=1){
				break;
				}
				if(a[x_temp-1][y_temp-1]==counter){
					maybe=1;
					change_x.push(x_temp);
					change_y.push(y_temp);
					k++;
				}
				if(a[x_temp-1][y_temp-1]==z){
					if(maybe==1){
					valid=true;
					validPart=true;
					//System.out.println("Valid in rud");
					}
					break;
				}
				x_temp=x_temp+1;
			y_temp=y_temp-1;
			}
			if(validPart==false){
					while(k!=0){
						temp = (int) change_x.pop();
						temp = (int) change_y.pop();
						k--;
					}
				}
			
			//right down diagonal
			
			y_temp=y;
			x_temp=x;
			maybe=0;
			x_temp=x_temp+1;
			y_temp=y_temp+1;
			k=0;
			validPart=false;
			while(x_temp!=9&&y_temp!=9){
				if(a[x_temp-1][y_temp-1]!=0&&a[x_temp-1][y_temp-1]!=1){
				break;
				}
				if(a[x_temp-1][y_temp-1]==counter){
					maybe=1;
					change_x.push(x_temp);
					change_y.push(y_temp);
					k++;
				}
				if(a[x_temp-1][y_temp-1]==z){
					if(maybe==1){
					valid=true;
					validPart=true;
					//System.out.println("Valid in rdd");
					}
					break;
				}
				x_temp=x_temp+1;
			y_temp=y_temp+1;
			}
			if(validPart==false){
					while(k!=0){
						temp = (int) change_x.pop();
						temp = (int) change_y.pop();
						k--;
					}
				}
			
			//left up diagonal
			y_temp=y;
			x_temp=x;
			maybe=0;
			x_temp=x_temp-1;
			y_temp=y_temp-1;
			k=0;
			validPart=false;
			while(x_temp!=0&&y_temp!=0){
				if(a[x_temp-1][y_temp-1]!=0&&a[x_temp-1][y_temp-1]!=1){
				break;
				}
				if(a[x_temp-1][y_temp-1]==counter){
					maybe=1;
					change_x.push(x_temp);
					change_y.push(y_temp);
					k++;
				}
				if(a[x_temp-1][y_temp-1]==z){
					if(maybe==1){
					valid=true;
					validPart=true;
					//System.out.println("Valid in lud");
					}
					break;
				}
				x_temp=x_temp-1;
			y_temp=y_temp-1;
			}
			if(validPart==false){
					while(k!=0){
						temp = (int) change_x.pop();
						temp = (int) change_y.pop();
						k--;
					}
				}
			
			//left down diagonal
			
			y_temp=y;
			x_temp=x;
			maybe=0;
			x_temp=x_temp-1;
			y_temp=y_temp+1;
			k=0;
			validPart=false;
			while(x_temp!=0&&y_temp!=9){
				if(a[x_temp-1][y_temp-1]!=0&&a[x_temp-1][y_temp-1]!=1){
				break;
				}
				if(a[x_temp-1][y_temp-1]==counter){
					maybe=1;
					change_x.push(x_temp);
					change_y.push(y_temp);
					k++;
				}
				if(a[x_temp-1][y_temp-1]==z){
					if(maybe==1){
					valid=true;
					validPart=true;
					//System.out.println("Valid in ldd");
					}
					break;
				}
				x_temp=x_temp-1;
			y_temp=y_temp+1;
			}
			if(validPart==false){
					while(k!=0){
						temp = (int) change_x.pop();
						temp = (int) change_y.pop();
						k--;
					}
				}
			
			
			k=change_x.size();
			//System.out.println("value of k:" +k);
				
			
			
			
			return valid;
			
	
	}
	
//......................................Main starts........................................................


	public static void main(String[] args){
		
		
		boolean end=false;
		boolean black_move=true;
		boolean white_move=true;
		boolean black_move_valid,white_move_valid;
		int black_count=0,white_count=0;
		for(int i=0;i<8;i++){
			for(int j=0;j<8;j++){
				a[i][j]=2;
			}
		}
		a[3][3]=0;
		a[4][4]=0;
		a[3][4]=1;
		a[4][3]=1;
		
		int black_move_col,black_move_row,white_move_row,white_move_col;
		printBoard();
		
		
		
		
		System.out.println("Enter your move");
		Scanner s= new Scanner(System.in);
		
		
		
		
		
		while(end==false){
			black_move=true;
			white_move=true;
			black_move_valid=false;
			white_move_valid=false;
			
			//Black move
			while(black_move==true){
			
			for(int i=0;i<8;i++){
				for(int j=0;j<8;j++){
					if(a[i][j]==3){
						if(isValid(i+1,j+1,1)){
							black_move_valid=true;
						}
						else{
						a[i][j]=2;}
					}else if(isValid(i+1,j+1,1))
					{a[i][j]=3;
						black_move_valid=true;
						}
				}
			}
			printBoard();
			System.out.println("Black move : ");
			if(black_move_valid==false){
				System.out.println("no valid move available");
				black_move=false;
				break;
			}
			
		
		black_move_col=s.nextInt();
		black_move_row=s.nextInt();
		if(isValid(black_move_col,black_move_row,1)){
		a[black_move_col-1][black_move_row-1]=1;
		int k=change_x.size();
			//System.out.println("value of k:" +k);
			while(k!=0){
				a[change_x.pop()-1][change_y.pop()-1]=1;
				k--;
			}
		//printBoard();
		black_move=false;
		}
		else {
			System.out.println("invalid");
			black_move=true;
		}
		}
		
		
		//White move
			while(white_move==true){
			
			for(int i=0;i<8;i++){
				for(int j=0;j<8;j++){
					if(a[i][j]==3){
						if(isValid(i+1,j+1,0)){
							white_move_valid=true;
						}
						else{
						a[i][j]=2;}
					}else if(isValid(i+1,j+1,0))
					{a[i][j]=3;
						white_move_valid=true;
						}
				}
			}
			printBoard();
			System.out.println("White move : ");
			if(white_move_valid==false){
				System.out.println("no valid move available");
				white_move=false;
				break;
			}
			
		
		white_move_col=s.nextInt();
		white_move_row=s.nextInt();
		if(isValid(white_move_col,white_move_row,0)){
			a[white_move_col-1][white_move_row-1]=0;
			int k=change_x.size();
			//System.out.println("value of k:" +k);
			while(k!=0){
				a[change_x.pop()-1][change_y.pop()-1]=0;
				k--;
			}
			//printBoard();
			white_move=false;
		}
		else{
			System.out.println("invalid");
			white_move=true;
		}
		}
		
			if(black_move_valid==false&&white_move_valid==false){
			System.out.println("Game Over");
			black_count=0;
			white_count=0;
			for(int i=0;i<8;i++){
				for(int j=0;j<8;j++){
					if(a[i][j]==1){
						black_count++;
					}else if(a[i][j]==0){
						white_count++;
					}
				}
			}
			if(black_count>white_count){
				System.out.println("Black wins");
			}
			else if(black_count<white_count){
				System.out.println("White wins");
			} else if(black_count==white_count){
				System.out.println("Draw");
			}
				System.out.println("Black score:"+black_count);
				System.out.println("White score:"+white_count);
			break;
			}
		
		
		}
		




	}

	
}
